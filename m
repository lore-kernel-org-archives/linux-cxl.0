Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B854836E467
	for <linux-cxl@vger.kernel.org>; Thu, 30 Apr 2026 23:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777591413; cv=none; b=pOwJORWFazEmy89trFUPNqWDF1NkLAmhgbuZjnitXg2jJwbmPwinWAvORt1AeBwBTuPUR709gEauNeWHWveTv1cV1dRal45grEXgw3Kfj9d/p940uKwqtqU/MLNHFIrH6kCapaDs5wb25GDnfujqoC0fzIjZcEi/RHK70R01xDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777591413; c=relaxed/simple;
	bh=c4SZhFpdfH2gKQ6qlG2PevqK3nZOHR6z2ilACiHLMVg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=gcLU4Gz9T+mloST/Zt0v786EJ1EqWQBPwyxFQ+dYpWbY1auOdeJ+eLJFnEmRTlYGNOVDtBQUAqD8pigX591EIrk3pQshCXayc/po0d8Bm+JbvG85h6jEq0R/Jb3G8isX05p+P7zGofEgSvHucJ3RZqmvhzjgHCen0pTFXZAtTnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYoE4bmP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYoE4bmP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2870C2BCB3;
	Thu, 30 Apr 2026 23:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777591413;
	bh=c4SZhFpdfH2gKQ6qlG2PevqK3nZOHR6z2ilACiHLMVg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=eYoE4bmPA+8YW83A0muAWwD3Ura2mjWOGbNElnjMH3hUrRqJPufihMyezORD/rFuw
	 4nHAVWz/GlI6bC3VPyIFzR1+yn/fnnOKhAG926vgfhukyjXkSmA0l5XGhUNfxxpi9c
	 wkL7Znm0X6AfOxDFgmpd4NA7TR6pLiUGP9rMOHA0eiBcQyUG15MBnDHEJUp/BbwP9o
	 h0mFS9bHK9JgwcoAEB6o2qYfmCW3GChP9v7SdbY7S6OkSpR6BnXkEn1jX+x+R3miAU
	 B2H8CrqKXGjg6OAJyxGOGwX3Qsgis/qzq2J3+ZuiXpKxBLv6r6YbZRYimP66jaxdUP
	 g7HUcMtoA0Azw==
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id E7EF5F4007C;
	Thu, 30 Apr 2026 19:23:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 30 Apr 2026 19:23:30 -0400
X-ME-Sender: <xms:cuTzaWopv9BZPNIJOf6ZA78UJaEglbgyCn00f1YvcqNaay1r-b72uw>
    <xme:cuTzabBcvAzjXvz3fUFuwuucy8GpvB7ivv-sfQXe1pimVD1q-5g6NZquRqDW2cXET
    H2YIIiKpvQgCrkBi32ygno2dxfK_WCMjHuZ3CBlta1kEmETOie5H8l3>
X-ME-Received: <xmr:cuTzaXe4qTZhSZeLG1KJ8mZrZQqzxq-PITWohptbefaQv8FWXxNTtFft5HfwcAZ2_Me4vklSS3f6zd1INqRmvz_Jboqyd1tOprs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekkeeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefkjghfufggtgfgsehtjeertddttdejnecuhfhrohhmpedfffgrnhcuhghi
    lhhlihgrmhhsucdlnhhvihguihgrmddfuceoughjsgifsehkvghrnhgvlhdrohhrgheqne
    cuggftrfgrthhtvghrnheptdekleekgfdtgeduieeitddtgfeugeeikeejffeuffeuteej
    ffekveetffelhfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegujhgsfidomhgvshhmthhp
    rghuthhhphgvrhhsohhnrghlihhthidqudejjedvfedtgeehhedqfeeffeelgedtgeejqd
    gujhgsfieppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgt
    phhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlvghjrghnug
    hrohdrlhhutggvrhhoqdhprghlrghusegrmhgurdgtohhmpdhrtghpthhtoheplhhinhhu
    gidqtgiglhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegujhgsfieskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepvggufigrrhgurdgtrhgvvgesrghmugdrtgho
    mhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoh
    epkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughh
    rghtrdgtohhmpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprh
    gtphhtthhopegurghvvgdrjhhirghnghesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:cuTzaTsUIGdSdn_oJeibSXhSbNDyRh4PUUJfpGhFRr8maToqrvfEaQ>
    <xmx:cuTzaeipIyR7KuAvH3LrWWnFC8t1UXAaLJSuYOAXECBT8RKugcequw>
    <xmx:cuTzabsTYE2rzVqS5dd3ighyAKY3nec2l57WRrzoZDw7z9SeXBdPsA>
    <xmx:cuTzaZ9L9BdzeEkBH9hYNfVjWS5JCtaJQR13huKVvAlWQ82EomBlgQ>
    <xmx:cuTzaRYAT-XRO15819EPgWl9GoDig2duJAIPbU7hGtjOyrAL2Ocm6oS9>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Apr 2026 19:23:30 -0400 (EDT)
Date: Thu, 30 Apr 2026 16:23:29 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: alejandro.lucero-palau@amd.com, 
 linux-cxl@vger.kernel.org, 
 djbw@kernel.org, 
 edward.cree@amd.com, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 edumazet@google.com, 
 dave.jiang@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>, 
 Ben Cheatham <benjamin.cheatham@amd.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Alison Schofield <alison.schofield@intel.com>
Message-ID: <69f3e4714219b_3291a9100fb@djbw-dev.notmuch>
In-Reply-To: <20260423180528.17166-5-alejandro.lucero-palau@amd.com>
References: <20260423180528.17166-1-alejandro.lucero-palau@amd.com>
 <20260423180528.17166-5-alejandro.lucero-palau@amd.com>
Subject: Re: [PATCH v26 4/8] cxl: Prepare memdev creation for type2
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
> creating a memdev leading to problems when obtaining cxl_memdev_state
> references from a CXL_DEVTYPE_DEVMEM type.
> 
> Modify check for obtaining cxl_memdev_state adding CXL_DEVTYPE_DEVMEM
> support.
> 
> Make devm_cxl_add_memdev accessible from an accel driver.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

This did not address the comment I had on the last posting about not
explicitly calling out accelerators.

https://lore.kernel.org/all/69cb4379e2b73_1b0cc610085@dwillia2-mobl4.notmuch/

So a small naming change to make this more palatable because the current
"cxl_memdev_type" is a superset of all possible CXL memdevs. In other
words, PCI_CLASS_MEMORY_CXL, requires the presence of a mailbox. Other
devices with CXL.mem may not be "accelerators".

See below a proposal to flip the polarity of the naming:

> ---
>  drivers/cxl/core/memdev.c | 15 +++++++++++--
>  drivers/cxl/cxlmem.h      |  6 ------
>  drivers/cxl/mem.c         | 45 +++++++++++++++++++++++++++++----------
>  include/cxl/cxl.h         |  6 ++++++
>  4 files changed, 53 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index b8ff1c07e528..ef39803bb139 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -7,6 +7,7 @@
>  #include <linux/slab.h>
>  #include <linux/idr.h>
>  #include <linux/pci.h>
> +#include <cxl/cxl.h>
>  #include <cxlmem.h>
>  #include "trace.h"
>  #include "core.h"
> @@ -579,9 +580,16 @@ static const struct device_type cxl_memdev_type = {
>  	.groups = cxl_memdev_attribute_groups,
>  };
>  
> +static const struct device_type cxl_accel_memdev_type = {
> +	.name = "cxl_accel_memdev",
> +	.release = cxl_memdev_release,
> +	.devnode = cxl_memdev_devnode,
> +};

/*
 * CXL memory device with mandatory PCI_CLASS_MEMORY_CXL functions
 * like a mailbox and corresponding sysfs ABI.
 */
static const struct device_type cxl_class_memdev_type = {
	.name = "cxl_memdev",
	.release = cxl_memdev_release,
	.devnode = cxl_memdev_devnode,
  	.groups = cxl_memdev_attribute_groups,
};

/* CXL memory device with no class device attributes */
static const struct device_type cxl_memdev_type = {
	.name = "cxl_memdev",
	.release = cxl_memdev_release,
	.devnode = cxl_memdev_devnode,
};

That ".name" can be the same between the types because to userspace they
are fundamentally the same type of object. The distinction can be
determined by walking sysfs to see what is there.

I do not want userspace to start keying off of the DEVTYPE uevent
variable distinction unless we have a really good reason for that.

>  bool is_cxl_memdev(const struct device *dev)
>  {
> -	return dev->type == &cxl_memdev_type;
> +	return (dev->type == &cxl_memdev_type ||
> +		dev->type == &cxl_accel_memdev_type);
>  }
>  EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, "CXL");
>  
> @@ -776,7 +784,10 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>  	dev->parent = cxlds->dev;
>  	dev->bus = &cxl_bus_type;
>  	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
> -	dev->type = &cxl_memdev_type;
> +	if (cxlds->type == CXL_DEVTYPE_DEVMEM)
> +		dev->type = &cxl_accel_memdev_type;
> +	else
> +		dev->type = &cxl_memdev_type;
>  	device_set_pm_not_required(dev);
>  	INIT_WORK(&cxlmd->detach_work, detach_memdev);
>  
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 776c50d1db51..92cca400d113 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -34,10 +34,6 @@
>  	(FIELD_GET(CXLMDEV_RESET_NEEDED_MASK, status) !=                       \
>  	 CXLMDEV_RESET_NEEDED_NOT)
>  
> -struct cxl_memdev_attach {
> -	int (*probe)(struct cxl_memdev *cxlmd);
> -};
> -
>  /**
>   * struct cxl_memdev - CXL bus object representing a Type-3 Memory Device
>   * @dev: driver core device object
> @@ -103,8 +99,6 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
>  
>  struct cxl_memdev *__devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
>  					 const struct cxl_memdev_attach *attach);
> -struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
> -				       const struct cxl_memdev_attach *attach);

One of the dirty aspects of my RFC was continuing with the idea that
drivers external to CXL would need to worry about all the details around
how to construct cxl_memdev_attach.

So similar to above I think we want to have a
devm_cxl_add_class_memdev() that only the cxl_pci driver uses, and a
specific export for the single-memdev-to-single-region case.
devm_cxl_add

I will move some of that into the rework of unregister_region() I am
doing to solve the sysfs region deletion race. It is a similar problem.

>  int devm_cxl_sanitize_setup_notifier(struct device *host,
>  				     struct cxl_memdev *cxlmd);
>  struct cxl_memdev_state;
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index fcffe24dcb42..ff858318091f 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -65,6 +65,26 @@ static int cxl_debugfs_poison_clear(void *data, u64 dpa)
>  DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
>  			 cxl_debugfs_poison_clear, "%llx\n");
>  
> +static void cxl_memdev_poison_enable(struct cxl_memdev_state *mds,
> +				     struct cxl_memdev *cxlmd,
> +				     struct dentry *dentry)
> +{
> +	/*
> +	 * Avoid poison debugfs for DEVMEM aka accelerators as they rely on
> +	 * cxl_memdev_state.
> +	 */

"Disable poison debugfs for memdevs without mailboxes."
