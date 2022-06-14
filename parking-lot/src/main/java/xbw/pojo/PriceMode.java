package xbw.pojo;

import lombok.Data;

@Data
public class PriceMode {
    private Integer id;
    private String mode;

    public PriceMode() {
    }

    public PriceMode(Integer id, String mode) {
        this.id = id;
        this.mode = mode;
    }
}
