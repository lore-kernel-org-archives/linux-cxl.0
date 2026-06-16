Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289A8426ED3
	for <linux-cxl@vger.kernel.org>; Tue, 16 Jun 2026 10:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781606760; cv=none; b=aThu3YHKPGWoGsf6xzyuZQjAPTKriYtC9yI72prjT8baAK1wz1qBHTU6vtCQ164+0C80fdR/vOLok+MWHasmd40xUHmBKYmRhJoJoV93WNEV9x/TT0VUNCclDGxempcEq5PQCIhoC0uRK4mywcB72QAYmMatKuj5+pXdZU4Rwhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781606760; c=relaxed/simple;
	bh=RyDYGSUAZzPrBxLyxdxRs0GAG4L+g0vNvbpHM1ylscg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7LANn8R2bCq7QSGbmv68o7t3Iqz8UCxYAt7tSkj7YX673GDce1wxOiqsU2RnGwXmvxSYetP0KOnbBQ8pjh6u/KNWOqLXPShSmBpcZcx5QUDufU1LTJTnjEO0w98/wwlVvSfalPePQZUDc0TpvTL5hpdKciDe6E3O8Pq6ESFCWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HlmQkGaM; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlmQkGaM"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-30bbe98c3f0so293709eec.0
        for <linux-cxl@vger.kernel.org>; Tue, 16 Jun 2026 03:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781606758; x=1782211558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y4EyEOHsDwmrw9NmEF6uLnNuB52AY+IQzNXxIBVext8=;
        b=HlmQkGaM+eUEuvcLAIPCcNS7ep3HuS4vKD+JbcCdyyGBn7RdFvg/daX2P3EQj2/yt5
         NP5Q6ALvmb9JcUpVtIUxm9imqU565qZEbJeidwFm1zGxJWOEBxV3iWq8dC3qeSicAqLf
         lqPhF8ak6kkB4Za2345k25aQDY5MdpPbgXa8uVdQbAsmx6vEdcxWnzLa8buhaGrk+JI3
         gUCpGOuNXM+FCNJdYEmUvymzjdaGAaM1Ax00sdnJ319T7hc0jo7t7z1bSYH9+yfDZgKY
         Hcblxyc2KTm3DR1lZo69GMT4BT8TaodFeJv63cc9HsxSeUbCIFWzhPF+Np2hqihRXtKH
         Fk1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781606758; x=1782211558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y4EyEOHsDwmrw9NmEF6uLnNuB52AY+IQzNXxIBVext8=;
        b=m0Uo8Vh1gTOa+TDErD2JGRUJUAGAPS2Ll0Q9TS9Ub0mDIlRel7Hye6KGhUZ+uTlQfQ
         WZO0J6V8tYKBkzjhGYOTpH1otGMDi8jct/AQ6dTequ+/9kVCexcHdGPBnO1mQODZo4gX
         XUkCbradjD/xPOlkqCQ3awjC/fNEtT5B9XfeqHrDJpupC6uPAnX0uC0ZNWtn7NQIMq4E
         XyFl64T064lzq+GtcqFMRklEhAaejTrnwGhAuX9XrUUx4eYBQyRN9Y1xRDfFe8CF54XA
         +YTRWm4m7O4MoGrjM2m+ozLvg0K3bI9MoLftVXPcymEofAmrboH09sPi2iEZTlNQSNY3
         Odnw==
X-Forwarded-Encrypted: i=1; AFNElJ/AUgjT2tg+/cXLBrxhMbnDrdOHuYwqhH+LY1h3aRKROZIDSs2qLItyL+9UiGLkUGdN6FPDWocQUR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJMdmMRSQYCTA4hZo/9JR9PIy0+WND45LZDbc+YlQIGhgDeD2D
	LM/MV5b41HpubhPvsf7Ikpn0YS3h+6p5uZ0VfwmFv0NIsbHN46ObrP4W
X-Gm-Gg: Acq92OGdyOtudP63KLlxKvW10GZepEMaQdjwVHfcFMauTbfiGQ9twpuWOXeQw5FJB91
	lSkUDU3UcOiCJXx49yBpndqg421McSoGiF8GCf2svFQFnt3/yAvlkcOy3z5bXSOBOCjwGVEzPHf
	Ef7zfxOg02P8mvJDCxZtq9BjhZew7jBwvu+oWIAj1ko6kR++gXGkCQdwoL78zicObcDWaa4HJ2J
	LA5WUi9lxTjAmgkkH7PiHDniUa+xwt/z+dr7IcD3vvmzBvFLrIgJ31ZfYrnlY7kuxgL7LkFegVz
	3GdgzKRfTL+YaQeESuu4B/6mCNb3hE4pZHat7fuqlJTKoKok3J5yzue1rHzbL7qlroa/nqoHiL3
	KwQah1eRjWIyc+D67zlS3qrqXFDhMEcVxv0OyIgi83Y3CSKSsJUQ5nWCWEzVbyjq3Oov4FsFM1Y
	iAdKX4WJP1UiZQAgRfw+qyPyeQ6Hc2UsX4B61W0OMDHFV1IoLxjDxL6p41TM5TLMHQil+onOLPh
	VnyEa2YNnI9h8F+MA==
X-Received: by 2002:a05:7300:1481:b0:2d1:d434:cfe3 with SMTP id 5a478bee46e88-3081fce92efmr10730479eec.0.1781606758072;
        Tue, 16 Jun 2026 03:45:58 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5cea89sm19980760eec.8.2026.06.16.03.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 03:45:57 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Tue, 16 Jun 2026 03:45:55 -0700
To: Dave Jiang <dave.jiang@intel.com>
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
	Dan Williams <djbw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <iweiny@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	John Groves <John@groves.net>, Gregory Price <gourry@gourry.net>,
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v6 5/7] cxl/region: Add extent output to region query
Message-ID: <ajEpYzpjk57kvv74@AnisaLaptop.localdomain>
References: <20260523095043.471098-1-anisa.su@samsung.com>
 <20260523095043.471098-6-anisa.su@samsung.com>
 <ad25c4ad-b967-46c5-a983-a0c0ceb7d825@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad25c4ad-b967-46c5-a983-a0c0ceb7d825@intel.com>

On Mon, Jun 08, 2026 at 05:08:19PM -0700, Dave Jiang wrote:
> 
> 
> On 5/23/26 2:50 AM, Anisa Su wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > DCD regions have 0 or more extents.  The ability to list those and their
> > properties is useful to end users.
> > 
> > Add an option for extent output to region queries.  An example of this
> > is:
> > 
> > 	$ ./build/cxl/cxl list -r 8 -Nu
> > 	{
> > 	  "region":"region8",
> > 	  ...
> > 	  "type":"dc",
> > 	  ...
> > 	  "extents":[
> > 	    {
> > 	      "offset":"0x10000000",
> > 	      "length":"64.00 MiB (67.11 MB)",
> > 	      "tag":"00000000-0000-0000-0000-000000000000"
> 
> I think the code emits "uuid". Update commit log.

oh yeah... updated~

> > 	    },
> > 	    {
> > 	      "offset":"0x8000000",
> > 	      "length":"64.00 MiB (67.11 MB)",
> > 	      "tag":"00000000-0000-0000-0000-000000000000"
> 
> same here
> 
Also updated

> DJ
> 
Thanks,
Anisa
> > 	    }
> > 	  ]
> > 	}
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > Changes:
> > [iweiny: s/tag/uuid/]
> > ---
> >  Documentation/cxl/cxl-list.txt | 29 +++++++++++++++++++++
> >  cxl/filter.h                   |  3 +++
> >  cxl/json.c                     | 47 ++++++++++++++++++++++++++++++++++
> >  cxl/json.h                     |  3 +++
> >  cxl/list.c                     |  3 +++
> >  util/json.h                    |  1 +
> >  6 files changed, 86 insertions(+)
> > 
> > diff --git a/Documentation/cxl/cxl-list.txt b/Documentation/cxl/cxl-list.txt
> > index 193860b..7512687 100644
> > --- a/Documentation/cxl/cxl-list.txt
> > +++ b/Documentation/cxl/cxl-list.txt
> > @@ -426,6 +426,35 @@ OPTIONS
> >  }
> >  ----
> >  
> > +-N::
> > +--extents::
> > +	Append Dynamic Capacity extent information.
> > +----
> > +13:34:28 > ./build/cxl/cxl list -r 8 -Nu
> > +{
> > +  "region":"region8",
> > +  "resource":"0xf030000000",
> > +  "size":"512.00 MiB (536.87 MB)",
> > +  "type":"dc",
> > +  "interleave_ways":1,
> > +  "interleave_granularity":256,
> > +  "decode_state":"commit",
> > +  "extents":[
> > +    {
> > +      "offset":"0x10000000",
> > +      "length":"64.00 MiB (67.11 MB)",
> > +      "uuid":"00000000-0000-0000-0000-000000000000"
> > +    },
> > +    {
> > +      "offset":"0x8000000",
> > +      "length":"64.00 MiB (67.11 MB)",
> > +      "uuid":"00000000-0000-0000-0000-000000000000"
> > +    }
> > +  ]
> > +}
> > +----
> > +
> > +
> >  -r::
> >  --region::
> >  	Specify CXL region device name(s), or device id(s), to filter the listing.
> > diff --git a/cxl/filter.h b/cxl/filter.h
> > index 70463c4..30e7fe2 100644
> > --- a/cxl/filter.h
> > +++ b/cxl/filter.h
> > @@ -31,6 +31,7 @@ struct cxl_filter_params {
> >  	bool alert_config;
> >  	bool dax;
> >  	bool media_errors;
> > +	bool extents;
> >  	int verbose;
> >  	struct log_ctx ctx;
> >  };
> > @@ -93,6 +94,8 @@ static inline unsigned long cxl_filter_to_flags(struct cxl_filter_params *param)
> >  		flags |= UTIL_JSON_DAX | UTIL_JSON_DAX_DEVS;
> >  	if (param->media_errors)
> >  		flags |= UTIL_JSON_MEDIA_ERRORS;
> > +	if (param->extents)
> > +		flags |= UTIL_JSON_EXTENTS;
> >  	return flags;
> >  }
> >  
> > diff --git a/cxl/json.c b/cxl/json.c
> > index e94c809..7922b32 100644
> > --- a/cxl/json.c
> > +++ b/cxl/json.c
> > @@ -1022,6 +1022,50 @@ void util_cxl_mappings_append_json(struct json_object *jregion,
> >  	json_object_object_add(jregion, "mappings", jmappings);
> >  }
> >  
> > +void util_cxl_extents_append_json(struct json_object *jregion,
> > +				  struct cxl_region *region,
> > +				  unsigned long flags)
> > +{
> > +	struct json_object *jextents;
> > +	struct cxl_region_extent *extent;
> > +
> > +	jextents = json_object_new_array();
> > +	if (!jextents)
> > +		return;
> > +
> > +	cxl_extent_foreach(region, extent) {
> > +		struct json_object *jextent, *jobj;
> > +		unsigned long long val;
> > +		char uuid_str[40];
> > +		uuid_t uuid;
> > +
> > +		jextent = json_object_new_object();
> > +		if (!jextent)
> > +			continue;
> > +
> > +		val = cxl_extent_get_offset(extent);
> > +		jobj = util_json_object_hex(val, flags);
> > +		if (jobj)
> > +			json_object_object_add(jextent, "offset", jobj);
> > +
> > +		val = cxl_extent_get_length(extent);
> > +		jobj = util_json_object_size(val, flags);
> > +		if (jobj)
> > +			json_object_object_add(jextent, "length", jobj);
> > +
> > +		cxl_extent_get_uuid(extent, uuid);
> > +		uuid_unparse(uuid, uuid_str);
> > +		jobj = json_object_new_string(uuid_str);
> > +		if (jobj)
> > +			json_object_object_add(jextent, "uuid", jobj);
> > +
> > +		json_object_array_add(jextents, jextent);
> > +		json_object_set_userdata(jextent, extent, NULL);
> > +	}
> > +
> > +	json_object_object_add(jregion, "extents", jextents);
> > +}
> > +
> >  struct json_object *util_cxl_region_to_json(struct cxl_region *region,
> >  					     unsigned long flags)
> >  {
> > @@ -1126,6 +1170,9 @@ struct json_object *util_cxl_region_to_json(struct cxl_region *region,
> >  		}
> >  	}
> >  
> > +	if (flags & UTIL_JSON_EXTENTS)
> > +		util_cxl_extents_append_json(jregion, region, flags);
> > +
> >  	if (cxl_region_qos_class_mismatch(region)) {
> >  		jobj = json_object_new_boolean(true);
> >  		if (jobj)
> > diff --git a/cxl/json.h b/cxl/json.h
> > index eb7572b..f9c07ab 100644
> > --- a/cxl/json.h
> > +++ b/cxl/json.h
> > @@ -20,6 +20,9 @@ struct json_object *util_cxl_region_to_json(struct cxl_region *region,
> >  void util_cxl_mappings_append_json(struct json_object *jregion,
> >  				  struct cxl_region *region,
> >  				  unsigned long flags);
> > +void util_cxl_extents_append_json(struct json_object *jregion,
> > +				  struct cxl_region *region,
> > +				  unsigned long flags);
> >  void util_cxl_targets_append_json(struct json_object *jdecoder,
> >  				  struct cxl_decoder *decoder,
> >  				  const char *ident, const char *serial,
> > diff --git a/cxl/list.c b/cxl/list.c
> > index 0b25d78..47d1351 100644
> > --- a/cxl/list.c
> > +++ b/cxl/list.c
> > @@ -59,6 +59,8 @@ static const struct option options[] = {
> >  		    "include alert configuration information"),
> >  	OPT_BOOLEAN('L', "media-errors", &param.media_errors,
> >  		    "include media-error information "),
> > +	OPT_BOOLEAN('N', "extents", &param.extents,
> > +		    "include extent information (Dynamic Capacity regions only)"),
> >  	OPT_INCR('v', "verbose", &param.verbose, "increase output detail"),
> >  #ifdef ENABLE_DEBUG
> >  	OPT_BOOLEAN(0, "debug", &debug, "debug list walk"),
> > @@ -135,6 +137,7 @@ int cmd_list(int argc, const char **argv, struct cxl_ctx *ctx)
> >  		param.decoders = true;
> >  		param.targets = true;
> >  		param.regions = true;
> > +		param.extents = true;
> >  		/*fallthrough*/
> >  	case 0:
> >  		break;
> > diff --git a/util/json.h b/util/json.h
> > index 560f845..79ae324 100644
> > --- a/util/json.h
> > +++ b/util/json.h
> > @@ -21,6 +21,7 @@ enum util_json_flags {
> >  	UTIL_JSON_TARGETS	= (1 << 11),
> >  	UTIL_JSON_PARTITION	= (1 << 12),
> >  	UTIL_JSON_ALERT_CONFIG	= (1 << 13),
> > +	UTIL_JSON_EXTENTS	= (1 << 14),
> >  };
> >  
> >  void util_display_json_array(FILE *f_out, struct json_object *jarray,
> 
