Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557D6C433EF
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Dec 2021 05:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355628AbhLBGCd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Dec 2021 01:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355624AbhLBGCc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 2 Dec 2021 01:02:32 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95C8C061574
        for <linux-cxl@vger.kernel.org>; Wed,  1 Dec 2021 21:59:09 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id i12so26915068pfd.6
        for <linux-cxl@vger.kernel.org>; Wed, 01 Dec 2021 21:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KhqT6Nl9zn8t7eT0YB+qvJhgWd8332yS5corgBRS5Cs=;
        b=tJ3A5f73rTy0ErX5HVYAnmPVEIVWeXB9kwipoWYAaONp+hmZFjpFceB5jFmLPgbcCF
         G309dk/B8uehBIigw6CmIWlt7jnzR5cVJ7FCek3kMtRq1CS3ah0pMqqq45tjVHXofRL2
         YiaO7EKiDXYDqOgTtI5wT8o4nOhWZSGdLofNfQzntiLY/4ueRMPvRMQ9FZYScf7i/thJ
         HubU0y7b9a9NklGPwg+eiK4AuaR2VxcoHPxXcgWS44k4RNrFu4u7dFlBhDLMzyDV+6m2
         ohakomYtZUa2B44HAdmXHfSLvQhRwI7inavTXm+rhEqr92ZYBZU6wEKG9EDwKU/8Jm1I
         CV3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KhqT6Nl9zn8t7eT0YB+qvJhgWd8332yS5corgBRS5Cs=;
        b=oPUnVaS0jIWx2dW/jBVuZVnpHMHlxfp8AOPiBrSjXe9145+UYbZ0fYVFDIgj90wERq
         qoFoHIdghGrbvZWLJc3Yao5K9gilVBIg3ptZ7KHJnSBivP5XOfuEtkJpIaNIOLSEjs9O
         SDj3DQu32CmD6m/JIak0sXAU55gOCXzqS5T3IUSKNZbAGmG2Pi+DNgzY2h8wDydVGs8H
         dXxBwFlmm5llguz/xtsfww/Mqc2ApSbAMk8HhS9ROJt4fRMEFJ6OKLUCLU0bO8D7NZrx
         Wq42dVjUfIHa+lCFKHJ/g5bF8lvAHm1DXg8jinYatXelpxqe/cCRX9ob4gsPb2VZuggP
         2Zjg==
X-Gm-Message-State: AOAM531J1Q3VNDgQ2PwkkBO5qWBdeiv6dtzeHauXQuQUQRgsAQ3kStJK
        X3DQL/UwlYcXfPdvLG+pzEEoaZb6JAgLyTegWKbWlw==
X-Google-Smtp-Source: ABdhPJyuoF38g6rp6AHdIgEGYPmI60mDGpur59JYd7emtLFs+wiDqVdvZNLMmR1tXgFSI777IthqSfm+0Fq4N5CgzUU=
X-Received: by 2002:a63:658:: with SMTP id 85mr8085798pgg.437.1638424749017;
 Wed, 01 Dec 2021 21:59:09 -0800 (PST)
MIME-Version: 1.0
References: <20211202043750.3501494-1-ben.widawsky@intel.com> <20211202043750.3501494-5-ben.widawsky@intel.com>
In-Reply-To: <20211202043750.3501494-5-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 1 Dec 2021 21:58:59 -0800
Message-ID: <CAPcyv4gQGeeBvPHwLC3h0mE75+dZ=5SujRY1+vZuUyCjvjUA6w@mail.gmail.com>
Subject: Re: [PATCH v2 04/14] cxl: Introduce topology host registration
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Dec 1, 2021 at 8:40 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> The description of the CXL topology will be conveyed by a platform
> specific entity that is expected to be a singleton. For ACPI based
> systems, this is ACPI0017. This cxl_topology_host is needed as a
> constraint for when CXL.mem connectivity can be verified from root to
> endpoint. Given that endpoints can attach at any point in time relative
> to when the root arrives CXL.mem connectivity needs to be revalidated at
> every topology host arrival / depart event.
>
> cxl_test makes for an interesting case. cxl_test creates an alternate
> universe where there are possibly two root topology hosts (a real
> ACPI0017/CEDT, and a fake ACPI0017/CEDT). For this to work in the
> future, cxl_acpi (or some future platform host driver) will need to be
> unloaded first.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
> Changes since v1
> - Commit message overhaul (Dan)

More critically this fixes an uninitialized variable bug in the call
to create the root port.

So this is missing:

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

However, I have line of sight to fixup all the get_topology_host users
to just walk the device tree, so I think we can get by without this
facility for now.

> ---
>  drivers/cxl/acpi.c     | 18 ++++++++++---
>  drivers/cxl/core/bus.c | 57 +++++++++++++++++++++++++++++++++++++++---
>  drivers/cxl/cxl.h      |  5 +++-
>  3 files changed, 73 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 9f88dec03b33..7bcb54e9fe00 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -225,8 +225,7 @@ static int add_host_bridge_uport(struct device *match, void *arg)
>                 return 0;
>         }
>
> -       port = devm_cxl_add_port(host, match, dport->component_reg_phys,
> -                                root_port);
> +       port = devm_cxl_add_port(match, dport->component_reg_phys, root_port);
>         if (IS_ERR(port))
>                 return PTR_ERR(port);
>         dev_dbg(host, "%s: add: %s\n", dev_name(match), dev_name(&port->dev));
> @@ -377,6 +376,11 @@ static int add_root_nvdimm_bridge(struct device *match, void *data)
>         return 1;
>  }
>
> +static void clear_topology_host(void *data)
> +{
> +       cxl_unregister_topology_host(data);
> +}
> +
>  static int cxl_acpi_probe(struct platform_device *pdev)
>  {
>         int rc;
> @@ -385,7 +389,15 @@ static int cxl_acpi_probe(struct platform_device *pdev)
>         struct acpi_device *adev = ACPI_COMPANION(host);
>         struct cxl_cfmws_context ctx;
>
> -       root_port = devm_cxl_add_port(host, host, CXL_RESOURCE_NONE, NULL);
> +       rc = cxl_register_topology_host(host);
> +       if (rc)
> +               return rc;
> +
> +       rc = devm_add_action_or_reset(host, clear_topology_host, host);
> +       if (rc)
> +               return rc;
> +
> +       root_port = devm_cxl_add_port(host, CXL_RESOURCE_NONE, root_port);
>         if (IS_ERR(root_port))
>                 return PTR_ERR(root_port);
>         dev_dbg(host, "add: %s\n", dev_name(&root_port->dev));
> diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> index 4bf355a3e396..97cbd7132b15 100644
> --- a/drivers/cxl/core/bus.c
> +++ b/drivers/cxl/core/bus.c
> @@ -25,6 +25,53 @@
>   */
>
>  static DEFINE_IDA(cxl_port_ida);
> +static DECLARE_RWSEM(topology_host_sem);
> +
> +static struct device *cxl_topology_host;
> +
> +int cxl_register_topology_host(struct device *host)
> +{
> +       down_write(&topology_host_sem);
> +       if (cxl_topology_host) {
> +               up_write(&topology_host_sem);
> +               pr_warn("%s host currently in use. Please try unloading %s",
> +                       dev_name(cxl_topology_host), host->driver->name);
> +               return -EBUSY;
> +       }
> +
> +       cxl_topology_host = host;
> +       up_write(&topology_host_sem);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_register_topology_host, CXL);
> +
> +void cxl_unregister_topology_host(struct device *host)
> +{
> +       down_write(&topology_host_sem);
> +       if (cxl_topology_host == host)
> +               cxl_topology_host = NULL;
> +       else
> +               pr_warn("topology host in use by %s\n",
> +                       cxl_topology_host->driver->name);
> +       up_write(&topology_host_sem);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_unregister_topology_host, CXL);
> +
> +static struct device *get_cxl_topology_host(void)
> +{
> +       down_read(&topology_host_sem);
> +       if (cxl_topology_host)
> +               return cxl_topology_host;
> +       up_read(&topology_host_sem);
> +       return NULL;
> +}
> +
> +static void put_cxl_topology_host(struct device *dev)
> +{
> +       WARN_ON(dev != cxl_topology_host);
> +       up_read(&topology_host_sem);
> +}
>
>  static ssize_t devtype_show(struct device *dev, struct device_attribute *attr,
>                             char *buf)
> @@ -362,17 +409,16 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
>
>  /**
>   * devm_cxl_add_port - register a cxl_port in CXL memory decode hierarchy
> - * @host: host device for devm operations
>   * @uport: "physical" device implementing this upstream port
>   * @component_reg_phys: (optional) for configurable cxl_port instances
>   * @parent_port: next hop up in the CXL memory decode hierarchy
>   */
> -struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
> +struct cxl_port *devm_cxl_add_port(struct device *uport,
>                                    resource_size_t component_reg_phys,
>                                    struct cxl_port *parent_port)
>  {
> +       struct device *dev, *host;
>         struct cxl_port *port;
> -       struct device *dev;
>         int rc;
>
>         port = cxl_port_alloc(uport, component_reg_phys, parent_port);
> @@ -391,7 +437,12 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
>         if (rc)
>                 goto err;
>
> +       host = get_cxl_topology_host();
> +       if (!host)
> +               return ERR_PTR(-ENODEV);
> +
>         rc = devm_add_action_or_reset(host, unregister_port, port);
> +       put_cxl_topology_host(host);
>         if (rc)
>                 return ERR_PTR(rc);
>
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 762d8254c7c6..6bafc2cd8f7a 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -152,6 +152,9 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>  #define CXL_RESOURCE_NONE ((resource_size_t) -1)
>  #define CXL_TARGET_STRLEN 20
>
> +int cxl_register_topology_host(struct device *host);
> +void cxl_unregister_topology_host(struct device *host);
> +
>  /*
>   * cxl_decoder flags that define the type of memory / devices this
>   * decoder supports as well as configuration lock status See "CXL 2.0
> @@ -279,7 +282,7 @@ struct cxl_dport {
>  };
>
>  struct cxl_port *to_cxl_port(struct device *dev);
> -struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
> +struct cxl_port *devm_cxl_add_port(struct device *uport,
>                                    resource_size_t component_reg_phys,
>                                    struct cxl_port *parent_port);
>
> --
> 2.34.1
>
