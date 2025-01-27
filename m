Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161281FDA65
	for <linux-cxl@vger.kernel.org>; Mon, 27 Jan 2025 10:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737975098; cv=none; b=Qb8GtNZLxVvDEW/12R63yRgUJ3WNJUCLDmDBib3rthDVRL2WoF/FX6xJHXi+og4QXL+aj/PDyf876hKXIvJVtejjfUEy7M3pzWH7r0pCGY8kox2CrktN/cN0rDOuoF27Jw4LQ4HUG+rsjKER2VDsEFJcCVxqG8BS30f0wFqDRtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737975098; c=relaxed/simple;
	bh=hJAIqmzawmfe9LELhAcSUL8tZMGgD/klUElO9IhMrls=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=deeGnW63XlvQIKrZFDG80/+/NxGj+WvuqF1/H+pe3i8Lr8i27RRAJDDeIvq1tXk5PZAoW3lPC8IfcYZSgy7+jg/zP7Tsy6dWWzIhIkIXIwPzNTzU8Fp1Z9Xh0LTqUGyjfGDPm2bpswghaUo+GOfa+JIqkGSkb+zvt0OQpUoInsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YhQCb4JT0z6M4R6;
	Mon, 27 Jan 2025 18:49:31 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id ED5671400D9;
	Mon, 27 Jan 2025 18:51:33 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 27 Jan
 2025 11:51:33 +0100
Date: Mon, 27 Jan 2025 10:51:32 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v1 14/19] cxl: Add support for fwctl RPC command to
 enable CXL feature commands
Message-ID: <20250127105132.000072dd@huawei.com>
In-Reply-To: <6794478dd8026_20f329455@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
	<20250122235159.2716036-15-dave.jiang@intel.com>
	<6794478dd8026_20f329455@dwillia2-xfh.jf.intel.com.notmuch>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)


> > +}
> > +
> > +static void *cxlctl_get_supported_features(struct cxl_features_state *cfs,
> > +					   const struct fwctl_rpc_cxl *rpc_in,
> > +					   size_t *out_len)
> > +{
> > +	struct cxl_mbox_get_sup_feats_out *feat_out;
> > +	struct cxl_mbox_get_sup_feats_in feat_in;
> > +	struct cxl_feat_entry *saved, *pos;
> > +	int requested, copied;
> > +	size_t out_size;
> > +	u32 count;
> > +	u16 start;
> > +
> > +	if (rpc_in->op_size != sizeof(feat_in))
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	if (copy_from_user(&feat_in, u64_to_user_ptr(rpc_in->in_payload),
> > +			   rpc_in->op_size))
> > +		return ERR_PTR(-EFAULT);
> > +
> > +	count = le32_to_cpu(feat_in.count);
> > +	start = le16_to_cpu(feat_in.start_idx);
> > +	requested = count / sizeof(*pos);
> > +
> > +	/*
> > +	 * Make sure that the total requested number of entries is not greater
> > +	 * than the total number of supported features allowed for userspace.
> > +	 */
> > +	if (start >= cfs->num_user_features)
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	requested = min_t(int, requested, cfs->num_user_features - start);
> > +
> > +	out_size = sizeof(struct fwctl_rpc_cxl_out) + sizeof(*feat_out) +
> > +		   requested * sizeof(*pos);
> > +
> > +	struct fwctl_rpc_cxl_out *rpc_out __free(kvfree) =
> > +		kvzalloc(out_size, GFP_KERNEL);
> > +	if (!rpc_out)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	rpc_out->size = sizeof(*feat_out) + requested * sizeof(*pos);
> > +	feat_out = (struct cxl_mbox_get_sup_feats_out *)rpc_out->payload;
> > +	if (requested == 0) {
> > +		feat_out->num_entries = cpu_to_le16(requested);
> > +		feat_out->supported_feats = cpu_to_le16(cfs->num_user_features);
> > +		rpc_out->retval = CXL_MBOX_CMD_RC_SUCCESS;
> > +		*out_len = out_size;
> > +		return no_free_ptr(rpc_out);
> > +	}
> > +
> > +	pos = &feat_out->ents[0];
> > +	saved = &cfs->entries[0];
> > +
> > +	copied = 0;
> > +	for (int i = 0; i < cfs->num_features; i++, saved++) {
> > +		if (is_cxl_feature_exclusive(saved))
> > +			continue;  
> 
> I think it's fine to let userspace see that exclusive features are
> present, just need to return EBUSY if userspace actually tries to use
> them.

To me, a poke it and see interface is really ugly.

In many cases we could let "get" through even if the we are using the interface
via some other kernel path and have it as exclusive.
(I don't know how useful that is, but maybe it makes sense).

If we ever do that, the only way to discover if an interface is available
will be to try the set interface.  Depending on design of feature
that might have side effects - hopefully get never does!

Alternatives:
1. Flag. Maybe add something that makes it discoverable if a feature is
   in exclusive mode or not.

2. Query type interface.  So a way to actually ask if a given feature is
   usable.

3. What we have here.  To me the simplest solution is hide what we can't
   be used.
 


> > +	/* These effects supported for all scope */
> > +	if ((effects & CXL_CMD_CONFIG_CHANGE_COLD_RESET ||
> > +	     (effects & CXL_CMD_EFFECTS_EXTEND &&
> > +	      (effects & CXL_CMD_CONFIG_CHANGE_CONV_RESET ||
> > +	       effects & CXL_CMD_CONFIG_CHANGE_CXL_RESET))) &&
> > +	    scope >= FWCTL_RPC_DEBUG_WRITE)
> > +		return true;  
> 
> Looks good for the known bits, but this needs to return false for the
> currently reserved bits because the driver can not assume a security
> model for future effects. If a future spec adds
> FWCTL_RPC_DEBUG_WRITE-safe effects, a new kernel is needed to allow
> those Feature commands through.
> 
> Sidenote: I wonder why the spec wasted one of its bits on an extend bit,
> but here we are. The 'extend' concept is typically something like
> "bit15: go look at this other field in this payload as this 16-bit field
> was exhausted", not "bit9: the bits above this originally defined 16 bit
> field now has more bits", oh well.

It's odd but corner case of going from 'unknown' state for the remaining
pair of bits to 0 means this and 1 means this. Naming though doesn't match
the spec that calls it CEL[11:10] valid.  Would be good to name
it closer to that as we may well have something in bits 12 and 15 in future
and it doesn't refer to them.

Jonathan
