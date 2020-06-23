package engineering.everest.hazelcast;

import com.hazelcast.client.HazelcastClient;
import com.hazelcast.client.config.ClientClasspathYamlConfig;
import com.hazelcast.client.config.ClientConfig;
import com.hazelcast.config.KubernetesConfig;
import com.hazelcast.core.HazelcastInstance;
import com.hazelcast.core.IMap;

public class App {
    public static void main(String[] args) {
        ClientConfig config = new ClientClasspathYamlConfig("hazelcast-client.yaml");

        HazelcastInstance client = HazelcastClient.newHazelcastClient(config);
        IMap<String, String> map = client.getMap("map");
        map.put("key", "value");
        if (map.get("key").equals("value")) {
            System.out.println("Connection Successful!");
        } else {
            throw new RuntimeException("Connection failed, check your configuration.");
        }
    }
}
