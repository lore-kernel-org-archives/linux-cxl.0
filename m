Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB31F1C07EA
	for <linux-cxl@vger.kernel.org>; Wed, 11 Dec 2024 05:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733895856; cv=pass; b=q6sxyJzLypeDPpQe6ZotiKKBeT3SYRjETo8i88+tFb6lPYRCAAYL+maDE42yFfNM3gX/pwdKCoOqxQKHSx3H4YSwZIvaw6VH3WHB7q1WUnvLze785P6jdhfXJ/bd6HzAq9mvd6LXDUTu5IsuZQiazrmDACi1mOHQfoeytFI2n5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733895856; c=relaxed/simple;
	bh=z+F5FeU1RQXz63DFutiJOI+mvgadx50AE6nWRkqKo4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cZfqYM1mIRKLhPhNQJdEj+0131soJfwYJbISNsTKO6zWS3mutq/9xJfLJQhjBuL7ktZo4bMy7st8DEgY3B2bBO+HKsQqPWjTUt86ljXcfOpMnOZnJYyW3lu5PnAQ4PUn19EVMGrfvfgrJWtFFE1Sqept+YFyrMSFuOko/uAROc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=RB4NU2ON; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="RB4NU2ON"
ARC-Seal: i=1; a=rsa-sha256; t=1733895852; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=k0mPKGbYFJYJ1B6Wr66P507WI8i6w47otafLKmVkHsJ6hW0lpqoygLqLya9q15johWO7YEvUEbDiEV2AagyGoexek6gAVLbqOcr5uNyqirXtXSPZTyAnbOVn6QBHRRX0m7tuaVGBkEWzv5SuHWgi279S5Z59Zob5kixdMtSvyn0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733895852; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=to5gXszjKT/1fKaqncz6aLma1sNr7S6jRXamZE8aMVk=; 
	b=Eg9sEi+4DBVRdubuINtRw1Kc9VGL17IdMMo8stUK5tFWGUVQyaaTUheV3BoU94Dh13tHFbwfaJTPDB87nFKVXnG1Eg7l8BJ3ORYnhc0SKejSUJ3Y2ljJq/pAHb41/8cHynHKr+QhYy9q129WQwnMOxd9m0GDgz5WlngPVtx2/FI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733895851;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=to5gXszjKT/1fKaqncz6aLma1sNr7S6jRXamZE8aMVk=;
	b=RB4NU2ONwPT3FAZJ65Zk0VAj+ox/tswQXV+zs1g/YaziF2P8fbAoEb26cx02OLRO
	BVG1e+2nJGevPeTjH0jIUEGHP0ZChjfpXHDtSSCY5BrL9cNIMS23Hcxmw9MdWpZ4vLU
	/9H8t/db9XZzyZi6XTpuGoGbaySACzd+9npNGsl4=
Received: by mx.zohomail.com with SMTPS id 173389585062257.5892887513354;
	Tue, 10 Dec 2024 21:44:10 -0800 (PST)
Message-ID: <be2c5161-07d5-4570-8fcd-7158c0a3608d@zohomail.com>
Date: Wed, 11 Dec 2024 13:44:08 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/mem: Hide RCD attributes when pre-requisites are
 missing
To: Dan Williams <dan.j.williams@intel.com>, dave.jiang@intel.com
Cc: alison.schofield@intel.com, linux-cxl@vger.kernel.org
References: <173386304532.1383902.17130961308615551692.stgit@dwillia2-xfh.jf.intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <173386304532.1383902.17130961308615551692.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr080112272f231bba46440aef0ea3d3540000458cf5e996484d602d85ec333280fc1dd1403538f58e41e9b8:zu08011227b1ec8f3a5be00c809fc0d1030000d60017502fad6aee51a2792def667515a946d587bfa551b08b:rf080112269f4811df95354361f0b2eb4500009c86f8a9f2b142376844cf1849ffcb48f00bb623a0b52b63:ZohoMail
X-ZohoMailClient: External

On 12/11/2024 4:37 AM, Dan Williams wrote:
> A recent change to avoid a NULL rcd_pcie_cap pointer consumption in
> rcd_pcie_cap_emit() [1] arranged for the problematic sysfs attributes to
> return an error on access. However, if the attributes always fail on
> read they should simply be hidden.
>
> Add a facility called @mem_groups that follows the same visibility rules
> as the "dev_groups" of the cxl_mem driver. It is expressly for
> PCI-device relative attributes, but that require the device to be
> additionally connected to the CXL port topology.
>
> Link: http://lore.kernel.org/20241129132825.569237-1-ming.li@zohomail.com
> Cc: Li Ming <ming.li@zohomail.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/memdev.c    |   14 +++++++++-----
>  drivers/cxl/core/port.c      |    3 +++
>  drivers/cxl/cxlmem.h         |    7 +++++--
>  drivers/cxl/mem.c            |    8 ++++++++
>  drivers/cxl/pci.c            |   21 +++++++++++++++++++--
>  tools/testing/cxl/test/mem.c |    2 +-
>  6 files changed, 45 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 84fefb76dafa..7801bf64aafa 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -616,8 +616,10 @@ static void detach_memdev(struct work_struct *work)
>  
>  static struct lock_class_key cxl_memdev_key;
>  
> -static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
> -					   const struct file_operations *fops)
> +static struct cxl_memdev *
> +cxl_memdev_alloc(struct cxl_dev_state *cxlds,
> +		 const struct file_operations *fops,
> +		 const struct attribute_group **mem_groups)
>  {
>  	struct cxl_memdev *cxlmd;
>  	struct device *dev;
> @@ -633,6 +635,7 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>  		goto err;
>  	cxlmd->id = rc;
>  	cxlmd->depth = -1;
> +	cxlmd->mem_groups = mem_groups;
>  
>  	dev = &cxlmd->dev;
>  	device_initialize(dev);
> @@ -1017,15 +1020,16 @@ static const struct file_operations cxl_memdev_fops = {
>  	.llseek = noop_llseek,
>  };
>  
> -struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
> -				       struct cxl_dev_state *cxlds)
> +struct cxl_memdev *
> +devm_cxl_add_memdev(struct device *host, struct cxl_dev_state *cxlds,
> +		    const struct attribute_group **mem_groups)
>  {
>  	struct cxl_memdev *cxlmd;
>  	struct device *dev;
>  	struct cdev *cdev;
>  	int rc;
>  
> -	cxlmd = cxl_memdev_alloc(cxlds, &cxl_memdev_fops);
> +	cxlmd = cxl_memdev_alloc(cxlds, &cxl_memdev_fops, mem_groups);
>  	if (IS_ERR(cxlmd))
>  		return cxlmd;
>  
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index af92c67bc954..a53f144bbac1 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1397,6 +1397,7 @@ static void delete_endpoint(void *data)
>  {
>  	struct cxl_memdev *cxlmd = data;
>  	struct cxl_port *endpoint = cxlmd->endpoint;
> +	struct device *parent = cxlmd->dev.parent;
>  	struct device *host = endpoint_host(endpoint);
>  
>  	scoped_guard(device, host) {
> @@ -1407,6 +1408,8 @@ static void delete_endpoint(void *data)
>  		}
>  		cxlmd->endpoint = NULL;
>  	}
> +	if (sysfs_update_groups(&parent->kobj, cxlmd->mem_groups))
> +		dev_info(parent, "CXL.mem sysfs attributes removed\n");
>  	put_device(&endpoint->dev);
>  	put_device(host);
>  }
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 2a25d1957ddb..9c5f2544da75 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -43,6 +43,7 @@
>   * @cxl_nvb: coordinate removal of @cxl_nvd if present
>   * @cxl_nvd: optional bridge to an nvdimm if the device supports pmem
>   * @endpoint: connection to the CXL port topology for this memory device
> + * @mem_groups: host device groups that change visibility based on cxl_mem attach
>   * @id: id number of this memdev instance.
>   * @depth: endpoint port depth
>   */
> @@ -54,6 +55,7 @@ struct cxl_memdev {
>  	struct cxl_nvdimm_bridge *cxl_nvb;
>  	struct cxl_nvdimm *cxl_nvd;
>  	struct cxl_port *endpoint;
> +	const struct attribute_group **mem_groups;
>  	int id;
>  	int depth;
>  };
> @@ -87,8 +89,9 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
>  	return is_cxl_memdev(port->uport_dev);
>  }
>  
> -struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
> -				       struct cxl_dev_state *cxlds);
> +struct cxl_memdev *
> +devm_cxl_add_memdev(struct device *host, struct cxl_dev_state *cxlds,
> +		    const struct attribute_group **mem_groups);
>  int devm_cxl_sanitize_setup_notifier(struct device *host,
>  				     struct cxl_memdev *cxlmd);
>  struct cxl_memdev_state;
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index a9fd5cd5a0d2..2d2a662c99d4 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -50,6 +50,7 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>  {
>  	struct cxl_port *parent_port = parent_dport->port;
>  	struct cxl_port *endpoint, *iter, *down;
> +	struct device *parent;
>  	int rc;
>  
>  	/*
> @@ -70,6 +71,13 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>  	if (IS_ERR(endpoint))
>  		return PTR_ERR(endpoint);
>  
> +	parent = cxlmd->dev.parent;
> +	rc = sysfs_update_groups(&parent->kobj, cxlmd->mem_groups);
> +	if (rc) {
> +		dev_err(parent, "CXL.mem sysfs attributes removed\n");
> +		return rc;
> +	}

Hi Dan,


I think the error log in devm_cxl_add_endpoint() should not be "CXL.mem sysfs attributes removed", "Failed to attach CXL.mem sysfs attributes" should be better?

Other looks good to me.

Reviewed-by: Li Ming <ming.li@zohomail.com>


Besides, RCEC address is stored in dport, but rcd upstream port pci express capability is a rcd capability, not a rch dport capability. Is it better to move rcd_pcie_cap into cxlds->regs? If yes, I can work on that.


