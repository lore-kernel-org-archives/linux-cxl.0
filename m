Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0349379EE1
	for <linux-cxl@vger.kernel.org>; Thu, 25 Jun 2026 09:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782379118; cv=none; b=BVGaUQfY3fEU651UozZH4ZaB8tO6A1A0tFQ5x7uvBuymXFF+gcRrueS7DNfbQVGTCJEA/PL+lyiYihujTdXd28G6Qcpqo1OZHW/05VFHmpF2CIFVi70/qVr5Kc0e78JMi/k1xZySARHjxrDl8hwrqNuKRG+4HxIVvQOLHW93D/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782379118; c=relaxed/simple;
	bh=FAA7Aq1RPu7EhVQFkK71XMxM6eTTiNWxUSJXK1kKY8M=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QG9jR0hgPQ4scxMQijquGdKZiWFKf/lC+qfElZWrSh/WNNieFonlLwhzpzRQpEwE6S0GOcbyIUykXRog3GBTzuqYCnBG5QYSQHDivgEajBm9ZJyDLHTpVpronQgNML2yPPoOE14pJTREpCLI3IofDLtGERvUVM1g6tIUcy/Sedc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7F1B1hw; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7F1B1hw"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-30c591fb1cbso2979951eec.1
        for <linux-cxl@vger.kernel.org>; Thu, 25 Jun 2026 02:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782379116; x=1782983916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+qesORQ0kTh5e8tzkV0G9+zKZSg59oQupwNKCuTss8Y=;
        b=W7F1B1hwjM2ZRu4I5WxV5lBpUheeNYw8gVKaviaIVrruLBHgABe1AIBtykr0eRzmv4
         Dib1GOqd7rvJiHL3DrmOlm10i1NJmPSQBrcPBsU6NyWn00DsLBgOZrWJm5RPtGwhHj/p
         +dMGlBhBxOzMWAcaNlVdKvvhKHu+XTNSL4Uqpl2vScKHp4YxRV72+Y2lWt+XxuFXwn0F
         5jvDPuiicWdYbxOMdOJmPNrcvSL31Bhbqhow9iXBiTX9xZK8pecs+Hz2EHZ505B69xhf
         FxxF2WySSGvn08khNI5ixIsbpD8suvAk3LSveAFjY3AoFSwFTT01/IPOTq2BYEyzz6Xw
         pudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782379116; x=1782983916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+qesORQ0kTh5e8tzkV0G9+zKZSg59oQupwNKCuTss8Y=;
        b=ilw57b1SO6EkYrjj9PoZpVScrfbzZrK9LsT5EJY6N8A9G9veALfOcENBuWlIP1Fe84
         tAU8Kd0+mKZE+cxtiSyz7COunsYgOFsf1KOYmm2pG7SGxSbizKkzkBeBEMbTHP+VHYEU
         teRi+vmPwBwGEYQgt5EuxL84xyWv3V6yUge1dKAf0+lMJf15kWnBC54OpeU2wRqclIwe
         vL2rWwCJ1bV+Bf9M4YPGlB1/pBcFdAKTwJqTg/FWovRCTGhotVfMcyAqiJdQ+93kCB4S
         tvyL7+s5vcyPaj4F4ry11x2HQTrQgdTtD4E1JY3TvdBjCwWku9Nc7D15TStVgV7e4Qi2
         FIVA==
X-Forwarded-Encrypted: i=1; AHgh+Rr4tCo3eKozc9cPdv+bCYFYloFoycm8geuTkhtxjB1QBVeWa9pB709QGCyrFtzWDvFlNQNApVuhcZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY6eVh4bmT64avEExk8lAXSVr3X9qu3WJonVrkxSdX1DWJsEeC
	VRgMR5FwYS5cilhn+yLs/9oEa3JZOxkB1WRFy50TRtnIU7gQxg5yMDCd
X-Gm-Gg: AfdE7cm4kpm8IoNnVV+yEx1Q1CVNuxs+CPuQyX+VU/cmYU41kePMGJIQim0foWbKLNE
	NpGOrQRH6SRm67hz78GmrIPl+m3wdPvQU74Zjp0V3eAIr+Lnd2HKXqUt99M4Oj84ZAoCo4zQRr2
	cZjsIFZkOB8yo8x0Fl+F+4ueHJyjV7cBZbrowzjoTEAYbDu+rz1QdZKD1VQ4IUD5G7ol1hakBIS
	ychu8SBOaQ0p7ziYfJeJg1+A2cPdMG7tFSssz20GsGLdWd/zQuISwE0ES/hJ0HNCdsNq5n8GcdM
	bxHLslmhxKuMiT4854nsgU2NtXS+DNHZIP5+S00+S7MOs99fd57IyfrBDcyqAOcgS9Fmy6aFPtm
	jQJSkk8MuPgfHQ/LAHYZ6VkpF/wDAEKiGWHNEqxjFsf10f0R40ePokJ9nGlH0FvK73KBShJhgM4
	o0scczdNHiVjaYO6VQoum69bJKSsoS/OqHoELkQb/ABebWhoQEvywqNpXEQ0Y7QsV9KHlDjwvRU
	lKyv/k=
X-Received: by 2002:a05:7300:e801:b0:2f2:6dde:df54 with SMTP id 5a478bee46e88-30c84e0bb70mr1849264eec.33.1782379115492;
        Thu, 25 Jun 2026 02:18:35 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c4c9dafsm8496136eec.1.2026.06.25.02.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 02:18:35 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Thu, 25 Jun 2026 02:18:34 -0700
To: Dave Jiang <dave.jiang@intel.com>
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
	Dan Williams <djbw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <iweiny@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	John Groves <John@groves.net>, Gregory Price <gourry@gourry.net>,
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v6 4/7] libcxl: Add extent functionality to DC regions
Message-ID: <ajzyail9KEDk59XZ@AnisaLaptop.localdomain>
References: <20260523095043.471098-1-anisa.su@samsung.com>
 <20260523095043.471098-5-anisa.su@samsung.com>
 <7ef3859e-2140-4daf-a9d5-ca7816fe9a4e@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ef3859e-2140-4daf-a9d5-ca7816fe9a4e@intel.com>

On Mon, Jun 08, 2026 at 05:05:58PM -0700, Dave Jiang wrote:
> 
> 
> On 5/23/26 2:50 AM, Anisa Su wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > DCD regions have 0 or more extents.  The ability to list those and their
> > properties is useful to end users.
> > 
> > Add extent scanning and reporting functionality to libcxl.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> Missing Anisa sign-off
> 
Added
> 
> > 
> > ---
> > Changes:
> > [alison: s/tag/uuid/ for extents]
> > ---
> >  Documentation/cxl/lib/libcxl.txt |  27 ++++++
> >  cxl/lib/libcxl.c                 | 138 +++++++++++++++++++++++++++++++
> >  cxl/lib/libcxl.sym               |   5 ++
> >  cxl/lib/private.h                |  11 +++
> >  cxl/libcxl.h                     |  11 +++
> >  5 files changed, 192 insertions(+)
> > 
> > diff --git a/Documentation/cxl/lib/libcxl.txt b/Documentation/cxl/lib/libcxl.txt
> > index 9921ac1..0ad294c 100644
> > --- a/Documentation/cxl/lib/libcxl.txt
> > +++ b/Documentation/cxl/lib/libcxl.txt
> > @@ -635,6 +635,33 @@ where its properties can be interrogated by daxctl. The helper
> >  cxl_region_get_daxctl_region() returns an 'struct daxctl_region *' that
> >  can be used with other libdaxctl APIs.
> >  
> > +EXTENTS
> > +-------
> > +
> > +=== EXTENT: Enumeration
> > +----
> > +struct cxl_region_extent;
> > +struct cxl_region_extent *cxl_extent_get_first(struct cxl_region *region);
> > +struct cxl_region_extent *cxl_extent_get_next(struct cxl_region_extent *extent);
> > +#define cxl_extent_foreach(region, extent) \
> > +        for (extent = cxl_extent_get_first(region); \
> > +             extent != NULL; \
> > +             extent = cxl_extent_get_next(extent))
> > +
> > +----
> > +
> > +=== EXTENT: Attributes
> > +----
> > +unsigned long long cxl_extent_get_offset(struct cxl_region_extent *extent);
> > +unsigned long long cxl_extent_get_length(struct cxl_region_extent *extent);
> > +void cxl_extent_get_uuid(struct cxl_region_extent *extent, uuid_t uuid);
> > +----
> > +
> > +Extents represent available memory within a dynamic capacity region.  Extent
> > +objects are available for informational purposes to aid in allocation of
> > +memory.
> > +
> > +
> >  include::../../copyright.txt[]
> >  
> >  SEE ALSO
> > diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
> > index be0bc03..c096666 100644
> > --- a/cxl/lib/libcxl.c
> > +++ b/cxl/lib/libcxl.c
> > @@ -635,6 +635,7 @@ static void *add_cxl_region(void *parent, int id, const char *cxlregion_base)
> >  	region->ctx = ctx;
> >  	region->decoder = decoder;
> >  	list_head_init(&region->mappings);
> > +	list_head_init(&region->extents);
> >  
> >  	region->dev_path = strdup(cxlregion_base);
> >  	if (!region->dev_path)
> > @@ -1257,6 +1258,143 @@ cxl_mapping_get_next(struct cxl_memdev_mapping *mapping)
> >  	return list_next(&region->mappings, mapping, list);
> >  }
> >  
> > +static void cxl_extents_init(struct cxl_region *region)
> > +{
> > +	const char *devname = cxl_region_get_devname(region);
> > +	struct cxl_ctx *ctx = cxl_region_get_ctx(region);
> > +	char *extent_path, *dax_region_path;
> > +	struct dirent *de;
> > +	DIR *dir = NULL;
> > +
> > +	if (region->extents_init)
> > +		return;
> > +	region->extents_init = 1;
> > +
> > +	dax_region_path = calloc(1, strlen(region->dev_path) + 64);
> > +	if (!dax_region_path) {
> > +		err(ctx, "%s: allocation failure\n", devname);
> > +		return;
> > +	}
> > +
> > +	extent_path = calloc(1, strlen(region->dev_path) + 100);
> > +	if (!extent_path) {
> > +		err(ctx, "%s: allocation failure\n", devname);
> > +		free(dax_region_path);
> > +		return;
> > +	}
> > +
> > +	sprintf(dax_region_path, "%s/dax_region%d",
> > +		region->dev_path, region->id);
> > +	dir = opendir(dax_region_path);
> > +	if (!dir) {
> > +		err(ctx, "no extents found (%s): %s\n",
> > +			strerror(errno), dax_region_path);
> > +		free(extent_path);
> > +		free(dax_region_path);
> > +		return;
> > +	}
> > +
> > +	while ((de = readdir(dir)) != NULL) {
> > +		struct cxl_region_extent *extent;
> > +		char buf[SYSFS_ATTR_SIZE];
> > +		u64 offset, length;
> > +		int id, region_id;
> > +
> > +		if (sscanf(de->d_name, "extent%d.%d", &region_id, &id) != 2)
> > +			continue;
> > +
> > +		sprintf(extent_path, "%s/extent%d.%d/offset",
> > +			dax_region_path, region_id, id);
> > +		if (sysfs_read_attr(ctx, extent_path, buf) < 0) {
> > +			err(ctx, "%s: failed to read extent%d.%d/offset\n",
> > +				devname, region_id, id);
> > +			continue;
> > +		}
> > +
> > +		offset = strtoull(buf, NULL, 0);
> > +		if (offset == ULLONG_MAX) {
> > +			err(ctx, "%s extent%d.%d: failed to read offset\n",
> > +				devname, region_id, id);
> > +			continue;
> > +		}
> > +
> > +		sprintf(extent_path, "%s/extent%d.%d/length",
> > +			dax_region_path, region_id, id);
> > +		if (sysfs_read_attr(ctx, extent_path, buf) < 0) {
> > +			err(ctx, "%s: failed to read extent%d.%d/length\n",
> > +				devname, region_id, id);
> > +			continue;
> > +		}
> > +
> > +		length = strtoull(buf, NULL, 0);
> > +		if (length == ULLONG_MAX) {
> > +			err(ctx, "%s extent%d.%d: failed to read length\n",
> > +				devname, region_id, id);
> > +			continue;
> > +		}
> > +
> > +		sprintf(extent_path, "%s/extent%d.%d/tag",
> > +			dax_region_path, region_id, id);
> > +		buf[0] = '\0';
> > +		if (sysfs_read_attr(ctx, extent_path, buf) != 0)
> > +			dbg(ctx, "%s extent%d.%d: failed to read uuid\n",
> > +				devname, region_id, id);
> > +
> > +		extent = calloc(1, sizeof(*extent));
> > +		if (!extent) {
> > +			err(ctx, "%s extent%d.%d: allocation failure\n",
> > +				devname, region_id, id);
> > +			continue;
> > +		}
> > +		if (strlen(buf) && uuid_parse(buf, extent->uuid) < 0)
> > +			err(ctx, "%s:%s\n", extent_path, buf);
> > +		extent->region = region;
> > +		extent->offset = offset;
> > +		extent->length = length;
> > +
> > +		list_node_init(&extent->list);
> > +		list_add(&region->extents, &extent->list);
> 
> free_region() never frees any of the extents allocated and added here and thus leak the memory when region is freed.
> 
added loop to free extents in free_region():

list_for_each_safe(&region->extents, extent, _e, list) {
	list_del_from(&region->extents, &extent->list);
	free(extent);
}
> 
> > +		dbg(ctx, "%s added extent%d.%d\n", devname, region_id, id);
> > +	}
> > +	free(dax_region_path);
> > +	free(extent_path);
> > +	closedir(dir);
> > +}
> > +
> > +CXL_EXPORT struct cxl_region_extent *
> > +cxl_extent_get_first(struct cxl_region *region)
> > +{
> > +	cxl_extents_init(region);
> > +
> > +	return list_top(&region->extents, struct cxl_region_extent, list);
> > +}
> > +
> > +CXL_EXPORT struct cxl_region_extent *
> > +cxl_extent_get_next(struct cxl_region_extent *extent)
> > +{
> > +	struct cxl_region *region = extent->region;
> > +
> > +	return list_next(&region->extents, extent, list);
> > +}
> > +
> > +CXL_EXPORT unsigned long long
> > +cxl_extent_get_offset(struct cxl_region_extent *extent)
> > +{
> > +	return extent->offset;
> > +}
> > +
> > +CXL_EXPORT unsigned long long
> > +cxl_extent_get_length(struct cxl_region_extent *extent)
> > +{
> > +	return extent->length;
> > +}
> > +
> > +CXL_EXPORT void
> > +cxl_extent_get_uuid(struct cxl_region_extent *extent, uuid_t uuid)
> > +{
> > +	memcpy(uuid, extent->uuid, sizeof(uuid_t));
> > +}
> > +
> >  CXL_EXPORT struct cxl_decoder *
> >  cxl_mapping_get_decoder(struct cxl_memdev_mapping *mapping)
> >  {
> > diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
> > index 258bdd3..dcfe242 100644
> > --- a/cxl/lib/libcxl.sym
> > +++ b/cxl/lib/libcxl.sym
> > @@ -298,6 +298,11 @@ global:
> >  	cxl_memdev_get_dynamic_ram_a_qos_class;
> >  	cxl_decoder_is_dynamic_ram_a_capable;
> >  	cxl_decoder_create_dynamic_ram_a_region;
> > +	cxl_extent_get_first;
> > +	cxl_extent_get_next;
> > +	cxl_extent_get_offset;
> > +	cxl_extent_get_length;
> > +	cxl_extent_get_uuid;
> >  } LIBECXL_8;

Now in LIBCXL_13

> >  
> >  LIBCXL_10 {
> > diff --git a/cxl/lib/private.h b/cxl/lib/private.h
> > index 37b7b06..c5f3bed 100644
> > --- a/cxl/lib/private.h
> > +++ b/cxl/lib/private.h
> > @@ -183,6 +183,7 @@ struct cxl_region {
> >  	struct cxl_decoder *decoder;
> >  	struct list_node list;
> >  	int mappings_init;
> > +	int extents_init;
> >  	struct cxl_ctx *ctx;
> >  	void *dev_buf;
> >  	size_t buf_len;
> > @@ -200,6 +201,7 @@ struct cxl_region {
> >  	struct daxctl_region *dax_region;
> >  	struct kmod_module *module;
> >  	struct list_head mappings;
> > +	struct list_head extents;
> >  };
> >  
> >  struct cxl_memdev_mapping {
> > @@ -209,6 +211,15 @@ struct cxl_memdev_mapping {
> >  	struct list_node list;
> >  };
> >  
> > +#define CXL_REGION_EXTENT_TAG 0x10
> 
> defined but never used
> 
thanks for the catch! deleted

> DJ
> 
Thanks,
Anisa
> > +struct cxl_region_extent {
> > +	struct cxl_region *region;
> > +	u64 offset;
> > +	u64 length;
> > +	uuid_t uuid;
> > +	struct list_node list;
> > +};
> > +
> >  enum cxl_cmd_query_status {
> >  	CXL_CMD_QUERY_NOT_RUN = 0,
> >  	CXL_CMD_QUERY_OK,
> > diff --git a/cxl/libcxl.h b/cxl/libcxl.h
> > index fd41122..a60509f 100644
> > --- a/cxl/libcxl.h
> > +++ b/cxl/libcxl.h
> > @@ -394,6 +394,17 @@ unsigned int cxl_mapping_get_position(struct cxl_memdev_mapping *mapping);
> >               mapping != NULL; \
> >               mapping = cxl_mapping_get_next(mapping))
> >  
> > +struct cxl_region_extent;
> > +struct cxl_region_extent *cxl_extent_get_first(struct cxl_region *region);
> > +struct cxl_region_extent *cxl_extent_get_next(struct cxl_region_extent *extent);
> > +#define cxl_extent_foreach(region, extent) \
> > +        for (extent = cxl_extent_get_first(region); \
> > +             extent != NULL; \
> > +             extent = cxl_extent_get_next(extent))
> > +unsigned long long cxl_extent_get_offset(struct cxl_region_extent *extent);
> > +unsigned long long cxl_extent_get_length(struct cxl_region_extent *extent);
> > +void cxl_extent_get_uuid(struct cxl_region_extent *extent, uuid_t uuid);
> > +
> >  struct cxl_cmd;
> >  const char *cxl_cmd_get_devname(struct cxl_cmd *cmd);
> >  struct cxl_cmd *cxl_cmd_new_raw(struct cxl_memdev *memdev, int opcode);
> 
