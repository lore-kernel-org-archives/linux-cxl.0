Received: from sender6-pp-o92.zoho.com (sender6-pp-o92.zoho.com [165.173.180.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3101B2EF2
	for <linux-cxl@vger.kernel.org>; Thu,  1 Oct 2026 01:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790819291; cv=pass; b=t3KD6hK8cjA7aYeaddjXIS0RMhOH5Can5mcj6oEKp1q7+tsjLE/xigr4TvVslM9kmTU8BGFtXi4Kd2UATaIdfb/eD85xjYQGWy3mH5amji85bmUfVxfVwAX307OdgHdPIPIoblLcAXM4zS5ZukHcSBqcre5rWClFjrM93TdqdGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790819291; c=relaxed/simple;
	bh=UHvIMCSjsnJhbY/V+vOcAwhMNE+4uQ4v5dOrekYAEKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WI78MtIJM05FBrr8nekJ14k4O+fjU26TnhS/KYaQUov/Iz2Vgbpsbnx2n1bV+eQp5xpjUK5q2jFepS+MEmL7vTNO4mZ43bAoFz5wfqLTKMZekwwPQT3gB1/iRaYAgRaoKYHJdH28x5PkEAm6xjiLi5443OMD52JtKvIsxtfBjcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=Q4LHrprv; arc=pass smtp.client-ip=165.173.180.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="Q4LHrprv"
ARC-Seal: i=1; a=rsa-sha256; t=1790819283; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WJywVEVMnhy9xYM8FKg41fOFvCNym+Yk2ismnQV7MXo3aEnJZBqK1a2ttMvu7fKskQ+JaHiKGAOO5GSN8pKJM5Qd04k/jQYvdZXr8JQUZBNwFc327wNWRhgnpaL54VAIp1jdiTgTIQ9B3qL3Yfx0m/gEKwf49GBWZ0GQxPRqsXo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1790819283; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=VUgy2QQ/mEqRUm8Atr5adybadF4dwXB6rDf1vercClI=; 
	b=grH36cEAcSQRMHWrGBTH51DVwi56mCLDkhGdn39RQfbpRx9KiHLpc2Fd8RTxkWFQeQYW3YTOWIT0mT0eByuKifKwM7MecIhTzwnz5O4stqNrN2uk+phpt4QkepI/LrxHPsPouSbSpbMViURJHOrK4RawRUU1J8moTt804HRuCa0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790819283;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=VUgy2QQ/mEqRUm8Atr5adybadF4dwXB6rDf1vercClI=;
	b=Q4LHrprvltuAPWqg78XDRPG97J4mJzeq1qPdl+mwPuuRULC6cANjKL9gZYHsBH5g
	bB79wWTsQC/rsT9w2xJ1iAjwNVw9Dmtbo3l/Uu8tJa+Qv9bk2rsXJrJEMwuMpmsBmTH
	ugFxBiD5ZqC998TU705dmP2NnAVnyAz1Qj+GWVbE=
Received: by smtp.zohomail.com with SMTPS id 1790819282126895.2854752832127;
	Wed, 30 Sep 2026 18:48:02 -0700 (PDT)
Message-ID: <c2a820e1-c95c-4c2a-be92-2d7ed0ad71cd@zohomail.com>
Date: Thu, 1 Oct 2026 09:47:59 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] cxl/core: Hold the dport host lock across dport
 lookup and use
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jic23@kernel.org, alison.schofield@intel.com,
 icheng@nvidia.com
References: <20260930152311.4164036-1-dave.jiang@intel.com>
 <20260930152311.4164036-3-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20260930152311.4164036-3-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: zu08011227ac401d325e7ed8a3e6356e580000f55bfe368229637104edbd9af1ae631c7d126a937cdb5f8e86:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External

On 9/30/2026 11:23 PM, Dave Jiang wrote:
> Callers of cxl_pci_find_port() and cxl_mem_find_port() can be handed a
> 'struct cxl_dport' that is already freed, and all four dereference it
> without the lock that would prevent that.
>
> A dport is kzalloc()'d into a devres group on its host device, so it dies
> when that host unbinds. The host is &port->dev for a switch port and
> port->uport_dev for the root port.
>
> Both helpers return the dport through an output parameter. The caller's
> port reference pins struct cxl_port, not the dport allocation, and the
> lookup itself is a bare xa_load() under no lock.
>
> Add cxl_port_dport_host() to name the device that pins a dport, and
> cxl_pci_find_dport() / cxl_mem_find_dport() to look one up with that
> device's lock held and asserted. Convert the four callers to use them and
> bail if the dport is gone. cxl_port_add_dport() already follows this rule.
>
> cxl_mem_probe() chose its endpoint devm host from dport->rch, which meant
> dereferencing the dport before taking any lock. Use cxl_port_dport_host():
> rch dports only ever land on the root port, so it selects the same device
> without needing the dport.
>
> Fixes: 733b57f262b0 ("cxl/pci: Early setup RCH dport component registers from RCRB")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Assisted-by: LLM
Reviewed-by: Li Ming <ming.li@zohomail.com>
> ---
> v2:
> - Reword the cxl_port_dport_host() comment. (Jonathan)
> - Drop the note on stale cxlsd->target[] pointers, fixed by patch 1. (Jonathan)
>
> Found by review, not from a failure report.
>
> Untested: two of the four converted sites add a new lock acquisition, and
> neither executed under test.
>
>   cxl_pci_setup_regs()        new guard() sits behind is_cxl_restricted(),
>                               which needs a PCI_EXP_TYPE_RC_END device
>   cxl_handle_rdport_errors()  needs an RCH dport AER error; cxl_test has no
>                               injection path
>
> Only cxl_pci_setup_regs() introduces a lock order lockdep has not already
> seen: device_lock(&pdev->dev) from probe, then the dport host lock.
>
> cxl_handle_rdport_errors() nests its new host lock inside the
> device_lock(&cxlmd->dev) that core/ras.c:274 and :298 hold, but
> cxl_mem_probe() takes that same pair in that same order and ran clean under
> PROVE_LOCKING, so the edge itself is covered. What is untested there is the
> path, not the ordering.
>
> Reaching either needs a cxl-type3 attached directly to a host bridge so
> pci_pcie_type() is PCI_EXP_TYPE_RC_END, which run_qemu.sh does not generate.
>
> Tested in QEMU with cxl_test, PROVE_LOCKING and KASAN on, 8 module
> load/unload cycles with concurrent sysfs readers. No lockdep splat, no
> device_lock_assert() firing, enumeration unchanged (15 memdev, 12 port,
> 192 decoder before and after).
>
> cxl_mem_find_dport() ran for 15 memdevs on each of 9 loads, covering both
> cxl_port_dport_host() branches. The rch branch is covered too: "cxl_mem
> mem2: endpoint9 added to root3" shows the new selection picking the same
> parent dport->rch did.
> ---
>  drivers/cxl/core/core.h    |  6 +-----
>  drivers/cxl/core/pci.c     |  8 +++++++-
>  drivers/cxl/core/port.c    | 36 ++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/ras_rch.c | 12 +++++++++++-
>  drivers/cxl/cxl.h          | 16 ++++++++++++++++
>  drivers/cxl/mem.c          | 14 +++++++++-----
>  drivers/cxl/pci.c          | 11 ++++++-----
>  7 files changed, 86 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 35eaf636adc9..0a39e500029a 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -178,11 +178,7 @@ static inline struct device *port_to_host(struct cxl_port *port)
>  
>  static inline struct device *dport_to_host(struct cxl_dport *dport)
>  {
> -	struct cxl_port *port = dport->port;
> -
> -	if (is_cxl_root(port))
> -		return port->uport_dev;
> -	return &port->dev;
> +	return cxl_port_dport_host(dport->port);
>  }
>  #ifdef CONFIG_CXL_RAS
>  void cxl_ras_init(void);
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 9d807c1a002c..8a236e22bb3f 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -734,10 +734,16 @@ int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev)) {
>  		struct cxl_dport *dport;
>  		struct cxl_port *port __free(put_cxl_port) =
> -			cxl_pci_find_port(pdev, &dport);
> +			cxl_pci_find_port(pdev, NULL);
>  		if (!port)
>  			return -EPROBE_DEFER;
>  
> +		guard(device)(cxl_port_dport_host(port));
> +
> +		dport = cxl_pci_find_dport(pdev, port);
> +		if (!dport)
> +			return -EPROBE_DEFER;
> +
>  		rc = cxl_rcrb_get_comp_regs(pdev, map, dport);
>  		if (rc)
>  			return rc;
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 6ff3353865e3..336d7c0f5d98 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1428,6 +1428,10 @@ static struct cxl_port *__find_cxl_port_by_dport(struct cxl_find_port_ctx *ctx)
>   *
>   * Return a 'struct cxl_port' with an elevated reference if found. Use
>   * __free(put_cxl_port) to release.
> + *
> + * The port reference does not pin @dport, which is a devm allocation of
> + * cxl_port_dport_host(). Pass NULL and use cxl_pci_find_dport() or
> + * cxl_mem_find_dport() under that device's lock instead.
>   */
>  static struct cxl_port *find_cxl_port_by_dport(struct device *dport_dev,
>  					       struct cxl_dport **dport)
> @@ -1943,6 +1947,38 @@ struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mem_find_port, "CXL");
>  
> +/**
> + * cxl_pci_find_dport - find the dport of @port that @pdev is below
> + * @pdev: PCI device below the dport
> + * @port: port to search, typically from cxl_pci_find_port()
> + *
> + * Context: Caller must hold the cxl_port_dport_host() lock of @port, and
> + *	    must not use the result after dropping it.
> + */
> +struct cxl_dport *cxl_pci_find_dport(struct pci_dev *pdev,
> +				     struct cxl_port *port)
> +{
> +	device_lock_assert(cxl_port_dport_host(port));
> +	return cxl_find_dport_by_dev(port, pdev->dev.parent);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_pci_find_dport, "CXL");
> +
> +/**
> + * cxl_mem_find_dport - find the dport of @port that @cxlmd is below
> + * @cxlmd: memdev below the dport
> + * @port: port to search, typically from cxl_mem_find_port()
> + *
> + * Context: Caller must hold the cxl_port_dport_host() lock of @port, and
> + *	    must not use the result after dropping it.
> + */
> +struct cxl_dport *cxl_mem_find_dport(struct cxl_memdev *cxlmd,
> +				     struct cxl_port *port)
> +{
> +	device_lock_assert(cxl_port_dport_host(port));
> +	return cxl_find_dport_by_dev(port, grandparent(&cxlmd->dev));
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_mem_find_dport, "CXL");
> +
>  static int decoder_populate_targets(struct cxl_switch_decoder *cxlsd,
>  				    struct cxl_port *port)
>  {
> diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
> index e0e01aa5eba6..827a2f64d892 100644
> --- a/drivers/cxl/core/ras_rch.c
> +++ b/drivers/cxl/core/ras_rch.c
> @@ -118,10 +118,20 @@ void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
>  	int severity;
>  
>  	struct cxl_port *port __free(put_cxl_port) =
> -		cxl_pci_find_port(pdev, &dport);
> +		cxl_pci_find_port(pdev, NULL);
>  	if (!port)
>  		return;
>  
> +	/*
> +	 * The dport may have been freed since the lookup above, so take the
> +	 * lock that pins it and find it again.
> +	 */
> +	guard(device)(cxl_port_dport_host(port));
> +
> +	dport = cxl_pci_find_dport(pdev, port);
> +	if (!dport)
> +		return;
> +
>  	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
>  		return;
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index cab8ce39f465..f08de094f412 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -701,6 +701,18 @@ static inline bool is_cxl_root(struct cxl_port *port)
>  	return port->uport_dev == port->dev.parent;
>  }
>  
> +/*
> + * Return the owner device of the devm allocations of @port's dports. They
> + * are freed when that device unbinds, so hold device_lock() on the returned
> + * device across any lookup and use of a 'struct cxl_dport'.
> + */
> +static inline struct device *cxl_port_dport_host(struct cxl_port *port)
> +{
> +	if (is_cxl_root(port))
> +		return port->uport_dev;
> +	return &port->dev;
> +}
> +
>  /* Address translation functions exported to cxl_translate test module only */
>  int cxl_validate_translation_params(u8 eiw, u16 eig, int pos);
>  u64 cxl_calculate_hpa_offset(u64 dpa_offset, int pos, u8 eiw, u16 eig);
> @@ -747,6 +759,10 @@ DEFINE_FREE(put_cxl_dax_region, struct cxl_dax_region *, if (!IS_ERR_OR_NULL(_T)
>  int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
>  void cxl_bus_rescan(void);
>  void cxl_bus_drain(void);
> +struct cxl_dport *cxl_pci_find_dport(struct pci_dev *pdev,
> +				     struct cxl_port *port);
> +struct cxl_dport *cxl_mem_find_dport(struct cxl_memdev *cxlmd,
> +				     struct cxl_port *port);
>  struct cxl_port *cxl_pci_find_port(struct pci_dev *pdev,
>  				   struct cxl_dport **dport);
>  struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 798e5c369cfc..91137487ac1f 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -133,7 +133,7 @@ static int cxl_mem_probe(struct device *dev)
>  		return rc;
>  
>  	struct cxl_port *parent_port __free(put_cxl_port) =
> -		cxl_mem_find_port(cxlmd, &dport);
> +		cxl_mem_find_port(cxlmd, NULL);
>  	if (!parent_port) {
>  		dev_err(dev, "CXL port topology not found\n");
>  		return -ENXIO;
> @@ -148,10 +148,7 @@ static int cxl_mem_probe(struct device *dev)
>  		}
>  	}
>  
> -	if (dport->rch)
> -		endpoint_parent = parent_port->uport_dev;
> -	else
> -		endpoint_parent = &parent_port->dev;
> +	endpoint_parent = cxl_port_dport_host(parent_port);
>  
>  	scoped_guard(device, endpoint_parent) {
>  		if (!endpoint_parent->driver) {
> @@ -160,6 +157,13 @@ static int cxl_mem_probe(struct device *dev)
>  			return -ENXIO;
>  		}
>  
> +		/* @dport is only valid while @endpoint_parent stays bound */
> +		dport = cxl_mem_find_dport(cxlmd, parent_port);
> +		if (!dport) {
> +			dev_err(dev, "CXL topology dport not found\n");
> +			return -ENXIO;
> +		}
> +
>  		rc = devm_cxl_add_endpoint(endpoint_parent, cxlmd, dport);
>  		if (rc)
>  			return rc;
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index c7c91e8dc51d..6e1d7ee94c19 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -706,22 +706,23 @@ static ssize_t rcd_pcie_cap_emit(struct device *dev, u16 offset, char *buf, size
>  	struct device *root_dev;
>  	struct cxl_dport *dport;
>  	struct cxl_port *root __free(put_cxl_port) =
> -		cxl_mem_find_port(cxlmd, &dport);
> +		cxl_mem_find_port(cxlmd, NULL);
>  
>  	if (!root)
>  		return -ENXIO;
>  
> -	root_dev = root->uport_dev;
> +	root_dev = cxl_port_dport_host(root);
>  	if (!root_dev)
>  		return -ENXIO;
>  
> -	if (!dport->regs.rcd_pcie_cap)
> -		return -ENXIO;
> -
>  	guard(device)(root_dev);
>  	if (!root_dev->driver)
>  		return -ENXIO;
>  
> +	dport = cxl_mem_find_dport(cxlmd, root);
> +	if (!dport || !dport->regs.rcd_pcie_cap)
> +		return -ENXIO;
> +
>  	switch (width) {
>  	case 2:
>  		return sysfs_emit(buf, "%#x\n",


