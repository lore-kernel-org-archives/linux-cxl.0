Received: from mail-m121157.qiye.163.com (mail-m121157.qiye.163.com [115.236.121.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB4E3C0E
	for <linux-cxl@vger.kernel.org>; Thu, 28 Dec 2023 07:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from [192.168.122.189] (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTPA id A68C6860149;
	Thu, 28 Dec 2023 14:43:45 +0800 (CST)
Subject: Re: [RFC PATCH 1/4] cxl: move some function from acpi module to core
 module
To: dave@stgolabs.net, jonathan.cameron@huawei.com, ave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org
References: <20231228060510.1178981-1-dongsheng.yang@easystack.cn>
 <20231228060510.1178981-2-dongsheng.yang@easystack.cn>
From: Dongsheng Yang <dongsheng.yang@easystack.cn>
Message-ID: <6a9f225f-9937-fd2a-ddc5-7006f8c1a16c@easystack.cn>
Date: Thu, 28 Dec 2023 14:43:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231228060510.1178981-2-dongsheng.yang@easystack.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlDT0NDVkxOTxhKHk9PT0odHVUZERMWGhIXJBQOD1
	lXWRgSC1lBWUlKQ1VCT1VKSkNVQktZV1kWGg8SFR0UWUFZT0tIVUpNT0lOSFVKS0tVSkJLS1kG
X-HM-Tid: 0a8caf2a2d6a023ckunma68c6860149
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mj46LSo4HzcxHyIOSkwVODYp
	LRkKCg5VSlVKTEtITE9OQ0lNTEpKVTMWGhIXVR8UFRwIEx4VHFUCGhUcOx4aCAIIDxoYEFUYFUVZ
	V1kSC1lBWUlKQ1VCT1VKSkNVQktZV1kIAVlBSklMTEg3Bg++



在 2023/12/28 星期四 下午 2:05, Dongsheng Yang 写道:
> cxl_virt module will create root_port without cxl_acpi_probe(),
> export these symbol to allow cxl_virt to create it's own root_port.
> 
> Signed-off-by: Dongsheng Yang <dongsheng.yang@easystack.cn>
> ---
>   drivers/cxl/acpi.c      | 143 +--------------------------------------
>   drivers/cxl/core/port.c | 145 ++++++++++++++++++++++++++++++++++++++++
>   drivers/cxl/cxl.h       |   5 ++
>   3 files changed, 151 insertions(+), 142 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 2034eb4ce83f..a60ed4156a5e 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -447,7 +447,7 @@ static int add_host_bridge_dport(struct device *match, void *arg)
>    * A host bridge is a dport to a CFMWS decode and it is a uport to the
>    * dport (PCIe Root Ports) in the host bridge.
>    */
> -static int add_host_bridge_uport(struct device *match, void *arg)
> +int add_host_bridge_uport(struct device *match, void *arg)

This change is included by mistake, it will be revert in next version

Thanx
>   {
>   	struct cxl_port *root_port = arg;
>   	struct device *host = root_port->dev.parent;
> @@ -504,30 +504,6 @@ static int add_host_bridge_uport(struct device *match, void *arg)
>   	return 0;
>   }
>   
> -static int add_root_nvdimm_bridge(struct device *match, void *data)
> -{
> -	struct cxl_decoder *cxld;
> -	struct cxl_port *root_port = data;
> -	struct cxl_nvdimm_bridge *cxl_nvb;
> -	struct device *host = root_port->dev.parent;
> -
> -	if (!is_root_decoder(match))
> -		return 0;
> -
> -	cxld = to_cxl_decoder(match);
> -	if (!(cxld->flags & CXL_DECODER_F_PMEM))
> -		return 0;
> -
> -	cxl_nvb = devm_cxl_add_nvdimm_bridge(host, root_port);
> -	if (IS_ERR(cxl_nvb)) {
> -		dev_dbg(host, "failed to register pmem\n");
> -		return PTR_ERR(cxl_nvb);
> -	}
> -	dev_dbg(host, "%s: add: %s\n", dev_name(&root_port->dev),
> -		dev_name(&cxl_nvb->dev));
> -	return 1;
> -}
> -
>   static struct lock_class_key cxl_root_key;
>   
>   static void cxl_acpi_lock_reset_class(void *dev)
> @@ -535,123 +511,6 @@ static void cxl_acpi_lock_reset_class(void *dev)
>   	device_lock_reset_class(dev);
>   }
>   
> -static void del_cxl_resource(struct resource *res)
> -{
> -	kfree(res->name);
> -	kfree(res);
> -}
> -
> -static void cxl_set_public_resource(struct resource *priv, struct resource *pub)
> -{
> -	priv->desc = (unsigned long) pub;
> -}
> -
> -static struct resource *cxl_get_public_resource(struct resource *priv)
> -{
> -	return (struct resource *) priv->desc;
> -}
> -
> -static void remove_cxl_resources(void *data)
> -{
> -	struct resource *res, *next, *cxl = data;
> -
> -	for (res = cxl->child; res; res = next) {
> -		struct resource *victim = cxl_get_public_resource(res);
> -
> -		next = res->sibling;
> -		remove_resource(res);
> -
> -		if (victim) {
> -			remove_resource(victim);
> -			kfree(victim);
> -		}
> -
> -		del_cxl_resource(res);
> -	}
> -}
> -
> -/**
> - * add_cxl_resources() - reflect CXL fixed memory windows in iomem_resource
> - * @cxl_res: A standalone resource tree where each CXL window is a sibling
> - *
> - * Walk each CXL window in @cxl_res and add it to iomem_resource potentially
> - * expanding its boundaries to ensure that any conflicting resources become
> - * children. If a window is expanded it may then conflict with a another window
> - * entry and require the window to be truncated or trimmed. Consider this
> - * situation:
> - *
> - * |-- "CXL Window 0" --||----- "CXL Window 1" -----|
> - * |--------------- "System RAM" -------------|
> - *
> - * ...where platform firmware has established as System RAM resource across 2
> - * windows, but has left some portion of window 1 for dynamic CXL region
> - * provisioning. In this case "Window 0" will span the entirety of the "System
> - * RAM" span, and "CXL Window 1" is truncated to the remaining tail past the end
> - * of that "System RAM" resource.
> - */
> -static int add_cxl_resources(struct resource *cxl_res)
> -{
> -	struct resource *res, *new, *next;
> -
> -	for (res = cxl_res->child; res; res = next) {
> -		new = kzalloc(sizeof(*new), GFP_KERNEL);
> -		if (!new)
> -			return -ENOMEM;
> -		new->name = res->name;
> -		new->start = res->start;
> -		new->end = res->end;
> -		new->flags = IORESOURCE_MEM;
> -		new->desc = IORES_DESC_CXL;
> -
> -		/*
> -		 * Record the public resource in the private cxl_res tree for
> -		 * later removal.
> -		 */
> -		cxl_set_public_resource(res, new);
> -
> -		insert_resource_expand_to_fit(&iomem_resource, new);
> -
> -		next = res->sibling;
> -		while (next && resource_overlaps(new, next)) {
> -			if (resource_contains(new, next)) {
> -				struct resource *_next = next->sibling;
> -
> -				remove_resource(next);
> -				del_cxl_resource(next);
> -				next = _next;
> -			} else
> -				next->start = new->end + 1;
> -		}
> -	}
> -	return 0;
> -}
> -
> -static int pair_cxl_resource(struct device *dev, void *data)
> -{
> -	struct resource *cxl_res = data;
> -	struct resource *p;
> -
> -	if (!is_root_decoder(dev))
> -		return 0;
> -
> -	for (p = cxl_res->child; p; p = p->sibling) {
> -		struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
> -		struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
> -		struct resource res = {
> -			.start = cxld->hpa_range.start,
> -			.end = cxld->hpa_range.end,
> -			.flags = IORESOURCE_MEM,
> -		};
> -
> -		if (resource_contains(p, &res)) {
> -			cxlrd->res = cxl_get_public_resource(p);
> -			break;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
>   static int cxl_acpi_probe(struct platform_device *pdev)
>   {
>   	int rc;
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 38441634e4c6..d8dae028e8a4 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -989,6 +989,151 @@ static int add_dport(struct cxl_port *port, struct cxl_dport *dport)
>   	return 0;
>   }
>   
> +int add_root_nvdimm_bridge(struct device *match, void *data)
> +{
> +	struct cxl_decoder *cxld;
> +	struct cxl_port *root_port = data;
> +	struct cxl_nvdimm_bridge *cxl_nvb;
> +	struct device *host = root_port->dev.parent;
> +
> +	if (!is_root_decoder(match))
> +		return 0;
> +
> +	cxld = to_cxl_decoder(match);
> +	if (!(cxld->flags & CXL_DECODER_F_PMEM))
> +		return 0;
> +
> +	cxl_nvb = devm_cxl_add_nvdimm_bridge(host, root_port);
> +	if (IS_ERR(cxl_nvb)) {
> +		dev_dbg(host, "failed to register pmem\n");
> +		return PTR_ERR(cxl_nvb);
> +	}
> +	dev_dbg(host, "%s: add: %s\n", dev_name(&root_port->dev),
> +		dev_name(&cxl_nvb->dev));
> +	return 1;
> +}
> +EXPORT_SYMBOL_NS_GPL(add_root_nvdimm_bridge, CXL);
> +
> +static void del_cxl_resource(struct resource *res)
> +{
> +	kfree(res->name);
> +	kfree(res);
> +}
> +
> +static void cxl_set_public_resource(struct resource *priv, struct resource *pub)
> +{
> +	priv->desc = (unsigned long) pub;
> +}
> +
> +static struct resource *cxl_get_public_resource(struct resource *priv)
> +{
> +	return (struct resource *) priv->desc;
> +}
> +
> +void remove_cxl_resources(void *data)
> +{
> +	struct resource *res, *next, *cxl = data;
> +
> +	for (res = cxl->child; res; res = next) {
> +		struct resource *victim = cxl_get_public_resource(res);
> +
> +		next = res->sibling;
> +		remove_resource(res);
> +
> +		if (victim) {
> +			remove_resource(victim);
> +			kfree(victim);
> +		}
> +
> +		del_cxl_resource(res);
> +	}
> +}
> +EXPORT_SYMBOL_NS_GPL(remove_cxl_resources, CXL);
> +
> +/**
> + * add_cxl_resources() - reflect CXL fixed memory windows in iomem_resource
> + * @cxl_res: A standalone resource tree where each CXL window is a sibling
> + *
> + * Walk each CXL window in @cxl_res and add it to iomem_resource potentially
> + * expanding its boundaries to ensure that any conflicting resources become
> + * children. If a window is expanded it may then conflict with a another window
> + * entry and require the window to be truncated or trimmed. Consider this
> + * situation:
> + *
> + * |-- "CXL Window 0" --||----- "CXL Window 1" -----|
> + * |--------------- "System RAM" -------------|
> + *
> + * ...where platform firmware has established as System RAM resource across 2
> + * windows, but has left some portion of window 1 for dynamic CXL region
> + * provisioning. In this case "Window 0" will span the entirety of the "System
> + * RAM" span, and "CXL Window 1" is truncated to the remaining tail past the end
> + * of that "System RAM" resource.
> + */
> +int add_cxl_resources(struct resource *cxl_res)
> +{
> +	struct resource *res, *new, *next;
> +
> +	for (res = cxl_res->child; res; res = next) {
> +		new = kzalloc(sizeof(*new), GFP_KERNEL);
> +		if (!new)
> +			return -ENOMEM;
> +		new->name = res->name;
> +		new->start = res->start;
> +		new->end = res->end;
> +		new->flags = IORESOURCE_MEM;
> +		new->desc = IORES_DESC_CXL;
> +
> +		/*
> +		 * Record the public resource in the private cxl_res tree for
> +		 * later removal.
> +		 */
> +		cxl_set_public_resource(res, new);
> +
> +		insert_resource_expand_to_fit(&iomem_resource, new);
> +
> +		next = res->sibling;
> +		while (next && resource_overlaps(new, next)) {
> +			if (resource_contains(new, next)) {
> +				struct resource *_next = next->sibling;
> +
> +				remove_resource(next);
> +				del_cxl_resource(next);
> +				next = _next;
> +			} else
> +				next->start = new->end + 1;
> +		}
> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(add_cxl_resources, CXL);
> +
> +int pair_cxl_resource(struct device *dev, void *data)
> +{
> +	struct resource *cxl_res = data;
> +	struct resource *p;
> +
> +	if (!is_root_decoder(dev))
> +		return 0;
> +
> +	for (p = cxl_res->child; p; p = p->sibling) {
> +		struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
> +		struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
> +		struct resource res = {
> +			.start = cxld->hpa_range.start,
> +			.end = cxld->hpa_range.end,
> +			.flags = IORESOURCE_MEM,
> +		};
> +
> +		if (resource_contains(p, &res)) {
> +			cxlrd->res = cxl_get_public_resource(p);
> +			break;
> +		}
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(pair_cxl_resource, CXL);
> +
>   /*
>    * Since root-level CXL dports cannot be enumerated by PCI they are not
>    * enumerated by the common port driver that acquires the port lock over
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 687043ece101..1397f66d943b 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -839,6 +839,11 @@ static inline struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
>   }
>   #endif
>   
> +void remove_cxl_resources(void *data);
> +int add_cxl_resources(struct resource *cxl_res);
> +int pair_cxl_resource(struct device *dev, void *data);
> +int add_root_nvdimm_bridge(struct device *match, void *data);
> +
>   /*
>    * Unit test builds overrides this to __weak, find the 'strong' version
>    * of these symbols in tools/testing/cxl/.
> 
