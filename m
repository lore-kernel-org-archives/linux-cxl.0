Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0744C3C6
	for <linux-cxl@vger.kernel.org>; Thu,  8 Feb 2024 20:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707425533; cv=none; b=nAIRjxHyUcEMM3tUOAknZglMA6c2QOTGbDOUtxPTiOeZiKZYxzbme26db283to5Nd10tqWeT8WlvVbbzwehjgo4pe2GBpQSGnRZCdBFSa4ENNdacLXwY+J4qRueN9/AVF2dbtRTk1p04TF6K9AoY8Of1+IQ3rOwTtwcYEamnAyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707425533; c=relaxed/simple;
	bh=DCCYQGb5RvKBODSPdk3yLQcMQtxPul99kaMp8jdos40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LlZGoWM+r0xXo9FmWVsokhU2hmBEMbeJZt4R4/InnCR3gajEFK9Np4JkWg+bqUSjZI2cWDaXWzocfO0ci5fX4bzKUXThPlJ9obmXTtySaRiArm+0ipXFyNvsArL2FOrw6zpRUPCH5zHW5VbaTHyJ/6PGQHwVAYteBBHU9HTjY1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S38/c8TU; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S38/c8TU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707425531; x=1738961531;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DCCYQGb5RvKBODSPdk3yLQcMQtxPul99kaMp8jdos40=;
  b=S38/c8TUvlHxe+JIV8QgSD71ZQRLFq5Ku0sYeu+/a5eVjF01btqjpH/b
   zE7Jah0gTvOW32OtdOV4mZIkPl4r0HurW6UrX6Ezs1KdQWPdp+hXlZAcn
   v0GvQDt1VwmulvSxVsV8Q1p5o8ey3jX1FtOAMr2Q1mQ2iqFkVde84r2HW
   QhTn6HlrgPCHukzFZWg3ip7ImRotKtxoYNNrx3LlQ1VSG4niNYe0HdgS9
   lBKUk5N359Oh7SSWO5B2CRf2a1WrW0Yy1LC5bgG/oqQN3cQ+KTBObp8hb
   +eZwP+ApLKKUYquMnzVQNxo1CAP79taEhur3+3FzrnPWuU6pH4RDjXVkR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="12396546"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="12396546"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 12:52:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="934247995"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="934247995"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.103.161])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 12:52:06 -0800
Date: Thu, 8 Feb 2024 12:52:04 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
	Wonjae Lee <wj28.lee@samsung.com>
Subject: Re: [RFC PATCH] cxl/region: Allow out of order assembly of
 autodiscovered regions
Message-ID: <ZcU+9BxBD8IRsnTu@aschofie-mobl2>
References: <20240113050421.1622533-1-alison.schofield@intel.com>
 <65a980249f50f_3b8e294a3@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65a980249f50f_3b8e294a3@dwillia2-xfh.jf.intel.com.notmuch>


On Thu, Jan 18, 2024 at 11:46:44AM -0800, Dan Williams wrote:

- snip to decoder replay patch -

> 
> So one of the largest roadblocks for creating arbitrary region assembly
> scenarios with cxl_test is the inability to save and restore decoder
> settings.
> 
> The patch below adds support for recording decoder settings and skipping
> the reset of those values when unloading the driver. Then, when the
> driver is reloaded, it simulates the case of BIOS created CXL regions
> prior to OS boot.
> 
> We can go after even finer grained cases once the uunit effort settles,
> but in the meantime cxl_test can add auto-assembly regression tests with
> the current topology.
> 
> With the below you can simply trigger "cxl {en,dis}able-memdev" in the
> proper order to cause the violation.
> 
> -- >8 --
> From 5839392a3dbb64dbbac0630d930b1f48a8ef7ea6 Mon Sep 17 00:00:00 2001
> From: Dan Williams <dan.j.williams@intel.com>
> Date: Wed, 17 Jan 2024 20:56:20 -0800
> Subject: [PATCH] tools/testing/cxl: Add decoder save/restore support
> 
> Record decoder values at init and mock_decoder_commit() time, and
> restore them at the next invocation of mock_init_hdm_decoder(). Add 2
> attributes to the cxl_test "cxl_acpi" device to optionally flush the
> cache of topology decoder values, or disable updating the decoder at
> mock_decoder_reset() time.
> 
> This enables replaying a saved decoder configuration when re-triggering
> a topology scan by re-binding the cxl_acpi driver to "cxl_acpi.0" (the
> cxl_test emulation of an ACPI0017 instance).

Hi Dan,

Sorry it's taken a while to come back on this. I did find it useful
in testing the auto-assembly order issue as you suggested. 

I didn't use this one: &dev_attr_decoder_registry_invalidate.attr,
I just reloaded the cxl-test module to do same.

This I used:  &dev_attr_decoder_registry_reset_disable.attr,
with your decoders state fixup to set CXL_DECODER_STATE_AUTO,
and a work-around to avoid pmem_probe failures on pmem region
auto create. 

More generally, I'm wondering about the implementation of the
'registry_save'. Here it continuously updates during all
cxl-test usage. Did you consider only creating the registry upon
user request and then at the next mock_init_hmd_decoder() look
for and use that registry if it exists.

Usage would be: 
# echo 1 > /sys/bus/platform/devices/cxl_acpi.0/decoder_registry_create
# echo cxl_acpi.0 > /sys/bus/platform/drivers/cxl_acpi/unbind
# echo cxl_acpi.0 > /sys/bus/platform/drivers/cxl_acpi/bind

And then maybe, for folks who like to acpi/unbind,bind, rather
than reload module, we could offer a decoder_registry_remove attr.

Am I missing something regarding the need to keep it updated
on the fly? 

Alison

> 
>     # modprobe cxl_test
>     # cxl list -RB -b cxl_test -u
>     {
>       "bus":"root3",
>       "provider":"cxl_test",
>       "regions:root3":[
>         {
>           "region":"region5",
>           "resource":"0xf010000000",
>           "size":"512.00 MiB (536.87 MB)",
>           "type":"ram",
>           "interleave_ways":2,
>           "interleave_granularity":4096,
>           "decode_state":"commit"
>         }
>       ]
>     }
>     # echo 1 > /sys/bus/platform/devices/cxl_acpi.0/decoder_registry_reset_disable
>     # echo cxl_acpi.0 > /sys/bus/platform/drivers/cxl_acpi/unbind
>     # cxl list -RB -b cxl_test -u
>     # echo cxl_acpi.0 > /sys/bus/platform/drivers/cxl_acpi/bind
>     # cxl list -RB -b cxl_test -u
>     {
>       "bus":"root3",
>       "provider":"cxl_test",
>       "regions:root3":[
>         {
>           "region":"region5",
>           "resource":"0xf010000000",
>           "size":"512.00 MiB (536.87 MB)",
>           "type":"ram",
>           "interleave_ways":2,
>           "interleave_granularity":4096,
>           "decode_state":"commit"
>         }
>       ]
>     }
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  tools/testing/cxl/test/cxl.c | 268 +++++++++++++++++++++++++++++++++++
>  1 file changed, 268 insertions(+)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index f4e517a0c774..3f333d6a57be 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -44,6 +44,9 @@ struct platform_device *cxl_mem_single[NR_MEM_SINGLE];
>  static struct platform_device *cxl_rch[NR_CXL_RCH];
>  static struct platform_device *cxl_rcd[NR_CXL_RCH];
>  
> +static DEFINE_XARRAY(decoder_registry);
> +static bool decoder_registry_reset_disable;
> +
>  static inline bool is_multi_bridge(struct device *dev)
>  {
>  	int i;
> @@ -660,6 +663,153 @@ static int map_targets(struct device *dev, void *data)
>  	return 0;
>  }
>  
> +static unsigned long cxld_registry_index(struct cxl_decoder *cxld)
> +{
> +	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
> +
> +	/*
> +	 * Upper nibble of a kernel pointer is 0xff, chop that to make
> +	 * space for a cxl_decoder id which should be less than 128
> +	 * given decoder count is a 4-bit field.
> +	 *
> +	 * While @port is reallocated each enumeration, @port->uport_dev
> +	 * is stable.
> +	 */
> +	dev_WARN_ONCE(&port->dev, cxld->id >= 128,
> +		      "decoder id:%d out of range\n", cxld->id);
> +	return (((unsigned long) port->uport_dev) << 4) | cxld->id;
> +}
> +
> +struct cxl_test_decoder {
> +	union {
> +		struct cxl_switch_decoder cxlsd;
> +		struct cxl_endpoint_decoder cxled;
> +	};
> +	union {
> +		struct cxl_dport *targets[CXL_DECODER_MAX_INTERLEAVE];
> +		struct range dpa_range;
> +	};
> +};
> +
> +static struct cxl_test_decoder *cxld_registry_find(struct cxl_decoder *cxld)
> +{
> +	return xa_load(&decoder_registry, cxld_registry_index(cxld));
> +}
> +
> +#define dbg_cxld(port, msg, cxld)                                                       \
> +	do {                                                                            \
> +		struct cxl_decoder *___d = (cxld);                                      \
> +		dev_dbg((port)->uport_dev,                                              \
> +			"decoder%d: %s range: %#llx-%#llx iw: %d ig: %d flags: %#lx\n", \
> +			___d->id, msg, ___d->hpa_range.start,                           \
> +			___d->hpa_range.end + 1, ___d->interleave_ways,                 \
> +			___d->interleave_granularity, ___d->flags);                     \
> +	} while (0)
> +
> +static int mock_decoder_commit(struct cxl_decoder *cxld);
> +static int mock_decoder_reset(struct cxl_decoder *cxld);
> +
> +static void cxld_copy(struct cxl_decoder *a, struct cxl_decoder *b)
> +{
> +	a->id = b->id;
> +	a->hpa_range = b->hpa_range;
> +	a->interleave_ways = b->interleave_ways;
> +	a->interleave_granularity = b->interleave_granularity;
> +	a->target_type = b->target_type;
> +	a->flags = b->flags;
> +	a->commit = mock_decoder_commit;
> +	a->reset = mock_decoder_reset;
> +}
> +
> +static void cxld_registry_restore(struct cxl_decoder *cxld, struct cxl_test_decoder *td)
> +{
> +	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
> +
> +	if (is_switch_decoder(&cxld->dev)) {
> +		struct cxl_switch_decoder *cxlsd = to_cxl_switch_decoder(&cxld->dev);
> +
> +		dbg_cxld(port, "restore", &td->cxlsd.cxld);
> +		cxld_copy(cxld, &td->cxlsd.cxld);
> +		WARN_ON(cxlsd->nr_targets != td->cxlsd.nr_targets);
> +
> +		/* convert saved dport devs to dports */
> +		for (int i = 0; i < cxlsd->nr_targets; i++) {
> +			struct cxl_dport *dport;
> +
> +			if (!td->cxlsd.target[i])
> +				continue;
> +			dport = cxl_find_dport_by_dev(
> +				port, (struct device *)td->cxlsd.target[i]);
> +			WARN_ON(!dport);
> +			cxlsd->target[i] = dport;
> +		}
> +	} else {
> +		struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(&cxld->dev);
> +
> +		dbg_cxld(port, "restore", &td->cxled.cxld);
> +		cxld_copy(cxld, &td->cxled.cxld);
> +		cxled->state = td->cxled.state;
> +		cxled->skip = td->cxled.skip;
> +		if (range_len(&td->dpa_range))
> +			devm_cxl_dpa_reserve(cxled, td->dpa_range.start,
> +					     range_len(&td->dpa_range),
> +					     td->cxled.skip);
> +		if (cxld->flags & CXL_DECODER_F_ENABLE)
> +			port->commit_end = cxld->id;
> +	}
> +}
> +
> +static void __cxld_registry_save(struct cxl_test_decoder *td,
> +				 struct cxl_decoder *cxld)
> +{
> +	if (is_switch_decoder(&cxld->dev)) {
> +		struct cxl_switch_decoder *cxlsd = to_cxl_switch_decoder(&cxld->dev);
> +
> +		cxld_copy(&td->cxlsd.cxld, cxld);
> +		td->cxlsd.nr_targets = cxlsd->nr_targets;
> +
> +		/* save dport devs as a stable placeholder for dports */
> +		for (int i = 0; i < cxlsd->nr_targets; i++) {
> +			if (!cxlsd->target[i])
> +				continue;
> +			td->cxlsd.target[i] =
> +				(struct cxl_dport *)cxlsd->target[i]->dport_dev;
> +		}
> +	} else {
> +		struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(&cxld->dev);
> +
> +		cxld_copy(&td->cxled.cxld, cxld);
> +		td->cxled.state = cxled->state;
> +		td->cxled.skip = cxled->skip;
> +		if (cxled->dpa_res) {
> +			td->dpa_range.start = cxled->dpa_res->start;
> +			td->dpa_range.end = cxled->dpa_res->end;
> +		} else {
> +			td->dpa_range.start = 0;
> +			td->dpa_range.end = -1;
> +		}
> +	}
> +}
> +
> +static void cxld_registry_save(struct cxl_test_decoder *td, struct cxl_decoder *cxld)
> +{
> +	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
> +
> +	dbg_cxld(port, "save", cxld);
> +	__cxld_registry_save(td, cxld);
> +}
> +
> +static void cxld_registry_update(struct cxl_decoder *cxld)
> +{
> +	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
> +	struct cxl_test_decoder *td = cxld_registry_find(cxld);
> +
> +	dev_WARN_ONCE(port->uport_dev, !td, "%s failed\n", __func__);
> +
> +	dbg_cxld(port, "update", cxld);
> +	__cxld_registry_save(td, cxld);
> +}
> +
>  static int mock_decoder_commit(struct cxl_decoder *cxld)
>  {
>  	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
> @@ -679,6 +829,7 @@ static int mock_decoder_commit(struct cxl_decoder *cxld)
>  
>  	port->commit_end++;
>  	cxld->flags |= CXL_DECODER_F_ENABLE;
> +	cxld_registry_update(cxld);
>  
>  	return 0;
>  }
> @@ -701,10 +852,43 @@ static int mock_decoder_reset(struct cxl_decoder *cxld)
>  
>  	port->commit_end--;
>  	cxld->flags &= ~CXL_DECODER_F_ENABLE;
> +	if (decoder_registry_reset_disable)
> +		dev_dbg(port->uport_dev, "decoder%d: skip registry update\n",
> +			cxld->id);
> +	else
> +		cxld_registry_update(cxld);
>  
>  	return 0;
>  }
>  
> +static void cxld_registry_invalidate(void)
> +{
> +	unsigned long index;
> +	void *entry;
> +
> +	xa_for_each(&decoder_registry, index, entry) {
> +		xa_erase(&decoder_registry, index);
> +		kfree(entry);
> +	}
> +}
> +
> +static struct cxl_test_decoder *cxld_registry_new(struct cxl_decoder *cxld)
> +{
> +	struct cxl_test_decoder *td __free(kfree) = kzalloc(sizeof(*td), GFP_KERNEL);
> +
> +	if (!td)
> +		return NULL;
> +
> +	if (xa_insert(&decoder_registry, cxld_registry_index(cxld), td,
> +		      GFP_KERNEL)) {
> +		WARN_ON(1);
> +		return NULL;
> +	}
> +
> +	cxld_registry_save(td, cxld);
> +	return no_free_ptr(td);
> +}
> +
>  static void default_mock_decoder(struct cxl_decoder *cxld)
>  {
>  	cxld->hpa_range = (struct range){
> @@ -717,6 +901,9 @@ static void default_mock_decoder(struct cxl_decoder *cxld)
>  	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
>  	cxld->commit = mock_decoder_commit;
>  	cxld->reset = mock_decoder_reset;
> +
> +	if (!cxld_registry_new(cxld))
> +		dev_dbg(&cxld->dev, "failed to add to registry\n");
>  }
>  
>  static int first_decoder(struct device *dev, void *data)
> @@ -738,6 +925,7 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
>  	struct cxl_endpoint_decoder *cxled;
>  	struct cxl_switch_decoder *cxlsd;
>  	struct cxl_port *port, *iter;
> +	struct cxl_test_decoder *td;
>  	const int size = SZ_512M;
>  	struct cxl_memdev *cxlmd;
>  	struct cxl_dport *dport;
> @@ -767,6 +955,12 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
>  		port = cxled_to_port(cxled);
>  	}
>  
> +	td = cxld_registry_find(cxld);
> +	if (td) {
> +		cxld_registry_restore(cxld, td);
> +		return;
> +	}
> +
>  	/*
>  	 * The first decoder on the first 2 devices on the first switch
>  	 * attached to host-bridge0 mock a fake / static RAM region. All
> @@ -795,6 +989,8 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
>  	devm_cxl_dpa_reserve(cxled, 0, size / cxld->interleave_ways, 0);
>  	cxld->commit = mock_decoder_commit;
>  	cxld->reset = mock_decoder_reset;
> +	if (!cxld_registry_new(cxld))
> +		dev_dbg(&cxld->dev, "failed to add to registry\n");
>  
>  	/*
>  	 * Now that endpoint decoder is set up, walk up the hierarchy
> @@ -837,6 +1033,7 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
>  			.start = base,
>  			.end = base + size - 1,
>  		};
> +		cxld_registry_update(cxld);
>  		put_device(dev);
>  	}
>  }
> @@ -1233,6 +1430,73 @@ static void cxl_single_exit(void)
>  	}
>  }
>  
> +static ssize_t decoder_registry_invalidate_show(struct device *dev,
> +						struct device_attribute *attr,
> +						char *buf)
> +{
> +	unsigned long index;
> +	bool empty = true;
> +	void *entry;
> +
> +	xa_for_each(&decoder_registry, index, entry) {
> +		empty = false;
> +		break;
> +	}
> +
> +	return sysfs_emit(buf, "%d\n", !empty);
> +}
> +
> +static ssize_t decoder_registry_invalidate_store(struct device *dev,
> +						 struct device_attribute *attr,
> +						 const char *buf, size_t count)
> +{
> +	bool invalidate;
> +	int rc;
> +
> +	rc = kstrtobool(buf, &invalidate);
> +	if (rc)
> +		return rc;
> +
> +	guard(device)(dev);
> +
> +	if (dev->driver)
> +		return -EBUSY;
> +
> +	cxld_registry_invalidate();
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RW(decoder_registry_invalidate);
> +
> +static ssize_t
> +decoder_registry_reset_disable_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%d\n", decoder_registry_reset_disable);
> +}
> +
> +static ssize_t
> +decoder_registry_reset_disable_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t count)
> +{
> +	int rc;
> +
> +	rc = kstrtobool(buf, &decoder_registry_reset_disable);
> +	if (rc)
> +		return rc;
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RW(decoder_registry_reset_disable);
> +
> +static struct attribute *cxl_acpi_attrs[] = {
> +	&dev_attr_decoder_registry_invalidate.attr,
> +	&dev_attr_decoder_registry_reset_disable.attr,
> +	NULL
> +};
> +ATTRIBUTE_GROUPS(cxl_acpi);
> +
>  static __init int cxl_test_init(void)
>  {
>  	int rc, i;
> @@ -1377,6 +1641,7 @@ static __init int cxl_test_init(void)
>  
>  	mock_companion(&acpi0017_mock, &cxl_acpi->dev);
>  	acpi0017_mock.dev.bus = &platform_bus_type;
> +	cxl_acpi->dev.groups = cxl_acpi_groups;
>  
>  	rc = platform_device_add(cxl_acpi);
>  	if (rc)
> @@ -1446,6 +1711,9 @@ static __exit void cxl_test_exit(void)
>  	depopulate_all_mock_resources();
>  	gen_pool_destroy(cxl_mock_pool);
>  	unregister_cxl_mock_ops(&cxl_mock_ops);
> +
> +	cxld_registry_invalidate();
> +	xa_destroy(&decoder_registry);
>  }
>  
>  module_param(interleave_arithmetic, int, 0444);
> -- 
> 2.43.0
