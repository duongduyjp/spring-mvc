package vn.hoidanit.laptopshop.util;

import org.springframework.data.domain.Page;
import org.springframework.ui.Model;
import org.springframework.stereotype.Component;

@Component
public class PaginationHelper {

    public static void addPaginationAttributes(Model model, Page<?> page, int currentPage, int pageSize) {
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalPages", page.getTotalPages());
        model.addAttribute("totalElements", page.getTotalElements());
        model.addAttribute("pageSize", pageSize);
    }

    public static String buildPaginationUrl(String baseUrl, String... queryParams) {
        StringBuilder url = new StringBuilder(baseUrl);
        if (queryParams.length > 0) {
            url.append("?");
            for (int i = 0; i < queryParams.length; i += 2) {
                if (i > 0)
                    url.append("&");
                url.append(queryParams[i]).append("=").append(queryParams[i + 1]);
            }
        }
        return url.toString();
    }
}