Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2286258F07C
	for <linux-cxl@vger.kernel.org>; Wed,  9 Sep 2026 21:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788988898; cv=none; b=Vf1xGpSRX1BYN/YJxzXmIXtDdgG72prMEQOVJZz/nCJkY0tId86pMQ3yNczKAE4KE2Dv4m8Ub5M9p2dZ8DpweTyAie39R4ttM6Djf9fzOHBCNC1z7ZZwR00tqj4jYT+kiXkgnQgFgIPOLntV2/fLDzH3IZMVbagblT3xeN8myJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788988898; c=relaxed/simple;
	bh=ZJHnAWnCGNiuLeuOJHTaBhGyK0h2bEkAfonlIPDDcL8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p1H0YS2aUQZtGKA13fE8fEhH3USTyfmDWXH2BgoZioERH+h56smwYB2K2tpjjxP5/IUyQ6Yh3S8KjTEOFsBNV9Ac45aAj/IKYdAwcwkqiB25KIMaY3/lZZuerOBVwmuYYUAF/MFUpojAdrIe8H5J9+XXpxAWHaGqPhENcLZtcCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdDsFLjq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdDsFLjq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E261F000FF;
	Wed,  9 Sep 2026 21:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788988896;
	bh=Bh7IjJkfviIKFfWvkJsG24I+yXziiGEpeascSMvkFLM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HdDsFLjqCi5pfTt8Rx1itjs+P6UOiOn06sU+hDrhtpo+WvOuTOhZTuS+ZglQUTm5i
	 EMQsUXzZ0/wEE9PG2rgC7fjMQxctYkQAc136p86XwhsUcEnh1I0MjQozAZm0f4rS4V
	 iFNJkDRy4i+8MZB8UxQuUl1KsbQo0XaCWTSF/QYHdRQ1n6j+EsDdejHyL34+KZVIgo
	 nGgecTgrPAzutDSHJQSV9vQ8d0YORJa4CYRdhDjjlAWYIm6RG1WbkvS2XWOQjJvszM
	 zvZ2pG73jNn8ZUzbPoNO6gg9uQIzJVZ/x4wbW73wblsAh4O1WZCr1pZUkHetbMaU7C
	 1JlXijaHKI6RQ==
Date: Wed, 9 Sep 2026 22:21:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: dave.jiang@intel.com, alison.schofield@intel.com, icheng@nvidia.com,
 ming.li@zohomail.com, benjamin.cheatham@amd.com, alucerop@amd.com,
 linux-cxl@vger.kernel.org, "John Groves" <john@groves.net>
Subject: Re: [PATCH v8 02/10] cxl/pci: Add BI topology enable/disable
Message-ID: <20260909222130.14387e8c@jic23-hlaptop>
In-Reply-To: <20260909170302.1550680-3-dave@stgolabs.net>
References: <20260909170302.1550680-1-dave@stgolabs.net>
	<20260909170302.1550680-3-dave@stgolabs.net>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Sep 2026 10:02:54 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

+CC John Groves.  Spec clarification maybe needed...

> Implement cxl_bi_setup() to enable BI flows on the device and every
> component in the path, and its teardown counterpart cxl_bi_dealloc().
> Setup runs from devm_cxl_endpoint_decoders_setup(), between the
> port's HDM state and its decoders: registered there, its devres
> teardown brings BI down after the decoders quiesce and before the
> HDM state is freed, and BI is settled before the decoders, and later
> the regions, are looked at. The BI-ID and path enablement belong to
> the endpoint port's lifetime.
> 
> Setup is safe in endpoint port probe context: the port probes
> synchronously from cxl_mem_probe(), pinning the memdev state the
> walk consumes, and the whole ancestor path already exists with BI
> registers mapped (dports at dport-add time, the switch USP RT at
> first-dport setup) because devm_cxl_enumerate_ports() completes
> before the endpoint is created.
> 
> Dealloc is safe in endpoint devres context: both setup and dealloc
> walk the endpoint's parent_dport topology rather than getting the
> port by bus lookup - an ancestor teardown delists the parent port
> before the endpoint's devres runs.
> 
> The topology walk is stable as parent_dport pointers are fixed at
> port creation; ancestors cannot be reaped while holding this
> memdev's cxl_ep; and their own teardown frees dports only after
> the endpoint is gone.
> 
> Likewise, the device state outlives the walk: cxlmd->cxlds is
> nulled only after cxl_memdev_unregister() has torn the endpoint
> down, and delete_endpoint() clears cxlmd->endpoint only after the
> endpoint devres has run.
> 
> Each dport is programmed by its position: the one immediately above
> the device assigns the BI-ID and takes BI Enable, every dport above
> it takes BI Forward (Table 8-157, Table 9-13), at any switch depth
> (Table 7-97). Any level can be shared, so nr_bi refcounts endpoints
> at every dport: registers are written on the first and cleared on
> the last, but only downstream ports commit (Table 8-156), once per
> endpoint (Table 8-152), and a failed commit undoes its write and
> commits the undo. A USP advertising a BI Route Table that failed to
> map is refused rather than treated as absent. nr_bi counts only the
> endpoints this driver enabled, so a level can be cleared while
> firmware still has an unbound device on it.
> 
> A reset may wipe the device's BI Enable, whose reset default is 0
> (Table 8-157). .reset_done reads the hardware rather than assume
> which reset ran, and invalidates cxlds->bi, failing closed with
> recovery by rebind as for decoder loss; dealloc unwinds the dport
> refcounts regardless. It also clears cxlds->bi unconditionally: the
> endpoint disable fails when the hardware already shows BI Enable
> clear, from a reset .reset_done never saw, and the flag must not
> outlive the BI Decoder mapping it describes, which the endpoint port
> releases moments later.
> 
> With dealloc in the endpoint's devres, delete_endpoint() already
> holds the parent port's device lock, so to avoid deadlocking, add a
> per-port bi_lock, serializing the dports that share state (nr_bi and
> the control register at any shared level, the switch USP's BI RT).
> 
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Hi Davidlohr,

A bit of a digression inline and a few places where I think minor tweaks
would make for more readable code.  Also a few requests for comments
on non obvious (to me anyway!) aspects.

Jonathan


> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index b8676a3d6ec9..8c3c00137849 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c

> @@ -965,3 +967,418 @@ void devm_cxl_dport_bi_setup(struct cxl_dport *dport)
>  		break;
>  	}
>  }
> +
> +/*
> + * BI requires 256B Flit operation on the link. RP/DSP/endpoint must
> + * also have the BI Decoder cap mapped (@bi); for USPs the BI RT cap
> + * is optional per CXL 4.0 8.2.4.26, so absent @bi is allowed.
> + */
> +static bool cxl_is_bi_capable(struct pci_dev *pdev, void __iomem *bi)
> +{
> +	if (!cxl_pci_flit_256(pdev))
> +		return false;
I'd burn some of that limited blank line supply up.
One here.

> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_UPSTREAM && !bi) {
> +		dev_dbg(&pdev->dev, "No BI Decoder registers.\n");
> +		return false;
> +	}

and one here.

> +	return true;
> +}

> +
> +/* BI RT only exists on switch upstream ports. */
> +static int __cxl_bi_commit_rt(struct device *dev, void __iomem *bi)
> +{
> +	u32 status, ctrl;
> +	unsigned int scale, base;
> +
> +	if (!FIELD_GET(CXL_BI_RT_CAPS_EXPLICIT_COMMIT_REQ,
> +		       readl(bi + CXL_BI_RT_CAPS_OFFSET)))
> +		return 0;
> +
> +	ctrl = readl(bi + CXL_BI_RT_CTRL_OFFSET);
> +	writel(ctrl & ~CXL_BI_RT_CTRL_BI_COMMIT, bi + CXL_BI_RT_CTRL_OFFSET);
> +	writel(ctrl | CXL_BI_RT_CTRL_BI_COMMIT, bi + CXL_BI_RT_CTRL_OFFSET);
> +
> +	status = readl(bi + CXL_BI_RT_STATUS_OFFSET);
> +	scale = FIELD_GET(CXL_BI_RT_STATUS_BI_COMMIT_TM_SCALE, status);
> +	base = FIELD_GET(CXL_BI_RT_STATUS_BI_COMMIT_TM_BASE, status);
> +
> +	return __cxl_bi_wait_commit(dev, bi + CXL_BI_RT_STATUS_OFFSET,
> +				    CXL_BI_RT_STATUS_BI_COMMITTED,
> +				    CXL_BI_RT_STATUS_BI_ERR_NOT_COMMITTED,
> +				    scale, base);
> +}

> +static int __cxl_bi_commit_decoder(struct device *dev, void __iomem *bi)

> +{
> +	u32 status, ctrl;
> +	unsigned int scale, base;
> +
> +	if (!FIELD_GET(CXL_BI_DECODER_CAPS_EXPLICIT_COMMIT_REQ,
> +		       readl(bi + CXL_BI_DECODER_CAPS_OFFSET)))
> +		return 0;
> +
> +	ctrl = readl(bi + CXL_BI_DECODER_CTRL_OFFSET);
> +	writel(ctrl & ~CXL_BI_DECODER_CTRL_BI_COMMIT,
> +	       bi + CXL_BI_DECODER_CTRL_OFFSET);
> +	writel(ctrl | CXL_BI_DECODER_CTRL_BI_COMMIT,
> +	       bi + CXL_BI_DECODER_CTRL_OFFSET);
> +
> +	status = readl(bi + CXL_BI_DECODER_STATUS_OFFSET);
> +	scale = FIELD_GET(CXL_BI_DECODER_STATUS_BI_COMMIT_TM_SCALE, status);
> +	base = FIELD_GET(CXL_BI_DECODER_STATUS_BI_COMMIT_TM_BASE, status);
> +
> +	return __cxl_bi_wait_commit(dev, bi + CXL_BI_DECODER_STATUS_OFFSET,
> +				    CXL_BI_DECODER_STATUS_BI_COMMITTED,
> +				    CXL_BI_DECODER_STATUS_BI_ERR_NOT_COMMITTED,
> +				    scale, base);
It's not clear to me if an attempt to do BI Decoder Commit when
both forward and enable are set to 0 might actually generate an
error.  I can't see any language either way.

> +}
> +static int cxl_bi_commit_dport(struct cxl_dport *dport)
> +{
> +	struct cxl_port *port = dport->port;
> +	int rc;
> +
> +	if (pci_pcie_type(to_pci_dev(dport->dport_dev)) !=
> +	    PCI_EXP_TYPE_DOWNSTREAM)
> +		return 0;
> +
> +	rc = __cxl_bi_commit_decoder(dport->dport_dev, dport->regs.bi_decoder);
> +	if (!rc && port->regs.bi_rt)
> +		rc = __cxl_bi_commit_rt(&port->dev, port->regs.bi_rt);
I'm lazy so haven't looked forward in series so maybe more comes after this.
As it stands:
	if (rc)
		return rc;

	if (port->regs.bi_rt)
		rc = __cxl_bi_commit_rt();

	return rc;

Is more readable.

> +
> +	return rc;
> +}
> +
> +/*
> + * Enable or dealloc BI-ID changes in the given level of the topology.
> + * @direct says this dport sits immediately above the device, which is
> + * what decides whether it assigns the BI-ID or forwards one assigned
> + * below it.
Bikeshed time.  Can we do better on that name or maybe just say 
what it controls rather than using the 'why'.  assigns_id maybe?
> + */
> +static int __cxl_bi_ctrl_dport(struct cxl_dport *dport, bool enable,
> +			       bool direct)
> +{
> +	void __iomem *bi = dport->regs.bi_decoder;
> +	struct cxl_port *port = dport->port;
> +	u32 ctrl, value, set, clr;
> +	int rc;
> +
> +	guard(mutex)(&port->bi_lock);
> +	if (!bi)
> +		return -EINVAL;
> +
> +	ctrl = readl(bi + CXL_BI_DECODER_CTRL_OFFSET);
> +
> +	if (!enable) {

There isn't really that much shared code between enable and disable paths.
Maybe just have separate functions / push the implementation down to
the wrappers?

> +		if (WARN_ON_ONCE(dport->nr_bi == 0))
> +			return -EINVAL;
> +		/* others below still need this level */
> +		if (--dport->nr_bi > 0)
> +			return 0;
> +
> +		writel(ctrl & ~(CXL_BI_DECODER_CTRL_BI_FW |
> +				CXL_BI_DECODER_CTRL_BI_ENABLE),
> +		       bi + CXL_BI_DECODER_CTRL_OFFSET);
> +		return cxl_bi_commit_dport(dport);
So this sent me on a wild goose chase.  The actual definitions
for committing rather imply that you don't need to commit when
turning it off, but the Implementation note in 9.14.2 
does have a commit sequence like you have here.

For reference we have: Table 8-156
"Explicit BI Decoder Commit Required" 
If 1, indicates that the software must set the BI decoder commit
bit whenever a new BI Device is enabled anywhere below this
port or any component below this port undergoes bus number
reassignment." which is the normative text and doesn't say anything
about commit being used when turning things off...

John, can you note this one down for possible discussion / clarification
in the spec?

> +	}
> +
> +	set = direct ? CXL_BI_DECODER_CTRL_BI_ENABLE :
> +		       CXL_BI_DECODER_CTRL_BI_FW;
> +	clr = direct ? CXL_BI_DECODER_CTRL_BI_FW :
> +		       CXL_BI_DECODER_CTRL_BI_ENABLE;
> +
> +	value = (ctrl | set) & ~clr;
> +	if (value != ctrl)
> +		writel(value, bi + CXL_BI_DECODER_CTRL_OFFSET);
> +
> +	/* owed per new device below, not per register change */
> +	rc = cxl_bi_commit_dport(dport);
> +	if (rc) {
> +		if (value != ctrl) {
> +			/* the undo is a BI-ID change owing its own commit */
> +			writel(ctrl, bi + CXL_BI_DECODER_CTRL_OFFSET);
> +			cxl_bi_commit_dport(dport);
As above, maybe this doesn't need to commit.

> +		}
> +		return rc;
> +	}
> +	dport->nr_bi++;
> +
> +	return 0;
> +}
> +
> +static int cxl_bi_ctrl_dport_enable(struct cxl_dport *dport, bool direct)
> +{
> +	return __cxl_bi_ctrl_dport(dport, true, direct);
> +}
> +
> +static int cxl_bi_ctrl_dport_disable(struct cxl_dport *dport)
> +{
> +	return __cxl_bi_ctrl_dport(dport, false, false);
> +}
> +
> +static int __cxl_bi_ctrl_endpoint(struct cxl_dev_state *cxlds, bool enable)
> +{
> +	struct cxl_port *endpoint = cxlds->cxlmd->endpoint;
> +	void __iomem *bi = endpoint->regs.bi_decoder;
> +	u32 ctrl, val;
> +
> +	if (!bi)
> +		return -EINVAL;
> +
> +	ctrl = readl(bi + CXL_BI_DECODER_CTRL_OFFSET);
> +
> +	if (enable) {
> +		if (FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl)) {
> +			if (cxlds->bi)
> +				return 0;
> +			dev_err(cxlds->dev,
> +				"BI already enabled in hardware\n");
> +			return -EBUSY;
> +		}
Maybe pull the sanity check out of the if (enable) - otherwise there isn't
all that much shared in here to justify the use. 

You could use a FIELD_MODIFY() to unify the set path as well.

> +		val = ctrl | CXL_BI_DECODER_CTRL_BI_ENABLE;
> +	} else {
> +		if (!FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl)) {
> +			if (!cxlds->bi)
> +				return 0;
> +			dev_err(cxlds->dev,
> +				"BI already disabled in hardware\n");
> +			return -EBUSY;
> +		}
> +		val = ctrl & ~CXL_BI_DECODER_CTRL_BI_ENABLE;
> +	}
> +
> +	writel(val, bi + CXL_BI_DECODER_CTRL_OFFSET);
> +	cxlds->bi = enable;
> +
> +	dev_dbg(cxlds->dev, "BI requests %s\n",
> +		str_enabled_disabled(enable));
> +
> +	return 0;
> +}

> +
> +/*
> + * devm teardown on endpoint port destruction. Registered before the
> + * decoders, so devres runs it after them: regions are detached and
> + * decoders unregistered by the time BI comes down.
> + */
> +static void cxl_bi_dealloc(void *data)
> +{
> +	struct cxl_port *endpoint = data;
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(endpoint->uport_dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_dport *dport_iter;
> +	struct cxl_port *port_iter;
> +
> +	scoped_guard(rwsem_read, &cxl_rwsem.region)

Maybe a comment on why the region lock is needed. I couldn't immediately
spot the answer and this is doing stuff that doesn't seem to have
much to do with regions.

> +		cxl_bi_ctrl_endpoint_disable(cxlds);
> +	cxlds->bi = false;
> +
> +	/*
> +	 * Walk the same parent_dport chain that enabled the path. A bus
> +	 * lookup cannot stand in for it: an ancestor-driven teardown
> +	 * delists the parent port before this devres action runs.
> +	 */
> +	dport_iter = endpoint->parent_dport;
> +	port_iter = dport_iter->port;
> +	while (!is_cxl_root(port_iter)) {
> +		int rc = cxl_bi_ctrl_dport_disable(dport_iter);
> +
> +		/* best effort */
> +		if (rc)
> +			dev_dbg(&port_iter->dev,
> +				"BI dport disable failed: %d\n", rc);
> +
> +		dport_iter = port_iter->parent_dport;
> +		port_iter = dport_iter->port;
> +	}
> +}
> +
> +/*
> + * Enable BI on every dport in the path, then on the device itself.
> + * On failure, unwind only the dports that fully enabled.

This 'fully' is a bit confusing.  Anything that is partly enabled is unwound
by the call that was doing that so those are handled, just prior to the goto
err_rollback.  Maybe just drop the word fully?

> + */
> +static int cxl_bi_enable_path(struct cxl_dev_state *cxlds,
> +			      struct cxl_port *port, struct cxl_dport *dport)
> +{
> +	struct cxl_dport *dport_iter, *failed;
> +	struct cxl_port *port_iter;
> +	int rc;
> +
> +	port_iter = port;
> +	dport_iter = dport;
> +	while (!is_cxl_root(port_iter)) {
> +		rc = cxl_bi_ctrl_dport_enable(dport_iter, dport_iter == dport);
> +		if (rc)
> +			goto err_rollback;
> +
> +		dport_iter = port_iter->parent_dport;
> +		port_iter = dport_iter->port;
> +	}
> +
> +	/* finally, enable BI on the device */

As comments go that one is a bit obvious given the function name.  Maybe drop.

> +	rc = cxl_bi_ctrl_endpoint_enable(cxlds);
> +	if (rc)
> +		goto err_rollback;
> +
> +	return 0;
> +
> +err_rollback:
> +	failed = dport_iter;
> +	dport_iter = dport;
> +	port_iter = port;
> +	while (!is_cxl_root(port_iter) && dport_iter != failed) {
> +		cxl_bi_ctrl_dport_disable(dport_iter);
> +		dport_iter = port_iter->parent_dport;
> +		port_iter = dport_iter->port;
> +	}
> +	return rc;
> +}

> +
> +int cxl_bi_setup(struct cxl_port *endpoint)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(endpoint->uport_dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_dport *dport = endpoint->parent_dport;
> +	struct cxl_dport *dport_iter;
> +	struct cxl_port *port_iter;
> +	int rc;
> +
> +	if (!dev_is_pci(cxlds->dev))
> +		return 0;
> +
> +	/* BI is VH-only */
> +	if (cxlds->rcd)
> +		return 0;
> +
> +	if (!cxl_is_bi_capable(to_pci_dev(cxlds->dev),
> +			       endpoint->regs.bi_decoder))
> +		return 0;
> +
> +	/* walkup the topology twice, first to check, then to enable */

Given the second walk is hidden in the helper function, maybe this
comment isn't necessary?

> +	port_iter = dport->port;
> +	dport_iter = dport;
> +	while (!is_cxl_root(port_iter)) {
> +		/* check rp, dsp */
> +		if (!cxl_is_bi_capable(to_pci_dev(dport_iter->dport_dev),
> +				       dport_iter->regs.bi_decoder)) {
> +			dev_dbg(cxlds->dev, "BI not supported by topology\n");
> +			return 0;
> +		}
> +
> +		/* check usp */
> +		if (dev_is_pci(port_iter->uport_dev) &&
> +		    pci_pcie_type(to_pci_dev(port_iter->uport_dev)) ==
> +			    PCI_EXP_TYPE_UPSTREAM) {
> +			if (!cxl_is_bi_capable(to_pci_dev(port_iter->uport_dev),
> +					       port_iter->regs.bi_rt)) {
> +				dev_dbg(cxlds->dev,
> +					"BI not supported by USP\n");
> +				return 0;
> +			}
> +			if (port_iter->reg_map.component_map.bi_rt.valid &&
> +			    !port_iter->regs.bi_rt) {
> +				dev_dbg(cxlds->dev,
> +					"BI RT advertised but unmapped\n");
> +				return 0;
> +			}
> +		}
> +
> +		dport_iter = port_iter->parent_dport;
> +		port_iter = dport_iter->port;
> +	}
> +
> +	rc = cxl_bi_enable_path(cxlds, dport->port, dport);
> +	if (rc)
> +		return rc;
> +
> +	return devm_add_action_or_reset(&endpoint->dev, cxl_bi_dealloc,
> +					endpoint);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_bi_setup, "CXL");

