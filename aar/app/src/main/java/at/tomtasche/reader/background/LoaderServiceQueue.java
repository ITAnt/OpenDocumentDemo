package at.tomtasche.reader.background;

import java.util.LinkedList;
import java.util.List;

public class LoaderServiceQueue {

    private List<QueueEntry> queue;

    private LoaderService service;

    public LoaderServiceQueue() {
        queue = new LinkedList<>();
    }

    public synchronized void addToQueue(QueueEntry entry) {
        System.out.println("LoaderServiceQueue: addToQueue called, service available: " + (service != null));
        if (service != null) {
            System.out.println("LoaderServiceQueue: Executing entry immediately");
            entry.onService(service);
            return;
        }

        System.out.println("LoaderServiceQueue: Adding entry to queue, current queue size: " + queue.size());
        queue.add(entry);
    }

    public synchronized LoaderService getService() {
        return service;
    }

    public synchronized void setService(LoaderService service) {
        System.out.println("LoaderServiceQueue: setService called, processing " + queue.size() + " queued entries");
        this.service = service;

        for (QueueEntry entry : queue) {
            System.out.println("LoaderServiceQueue: Processing queued entry");
            entry.onService(service);
        }
        
        queue.clear();
        System.out.println("LoaderServiceQueue: All queued entries processed");
    }

    public interface QueueEntry {
        public void onService(LoaderService service);
    }
}
