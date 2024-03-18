Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67D258230
	for <linux-cxl@vger.kernel.org>; Mon, 18 Mar 2024 21:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710796882; cv=none; b=CWMT/dd6fSMfJD6OHutap8HAAiETwN/jS9vLePmcymCdN59cmPrKw4oL6AiHtLzyU1CeTWOzpotTVbP6JqLFOXWTmLe7ZJt5LdJzT2CoFOJtoza0UfiYN7HVnn3vP8DDl2GYttaaJnT9fz9vQfAh8T2P3ETUcvbaUJlXDrwN1RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710796882; c=relaxed/simple;
	bh=Ugn1KmPnu11aPFUzigk4sAoCGx66V/lB5EhTs0ES1OU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hT3vyE9I0vszdufL2necHm5TrOCIKoS+VvvAsakdahw8RTne50gaELLbf4TbEu1COgwizHt5/MPkT0oU00nMlmRdNYljEs1OxAt12kZsAv0jHH++kG7O4z003J0vEEAMmVT8zT2aeVylU1p8jA01hXnXiWLf6/AYP2KH03HvwmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHSeaW3T; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHSeaW3T"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-60cc4124a39so50900207b3.3
        for <linux-cxl@vger.kernel.org>; Mon, 18 Mar 2024 14:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710796879; x=1711401679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DIxUkrf6TpjzqxMTzKqkU226vSY1+JGwyYdxIRGHbw0=;
        b=DHSeaW3TQoznSfxoEkIUbyKInvSIJUcLQzH0E8NZc5OnRbkE4GvnAb56D6DEZTRVL6
         azBfbOm3Y4Ytdb8G2t+ooFYetExLYGd8/hfQmmm3t+ZQF13E/W4abt//xkFvPJwA48Gl
         kaq5JiWxgB7ZwXDx12b0EdL8DKwxWKpLQNbyfK3G28hFmMretVGvyWVOIIHLH74sZsve
         KgcvJulJCflyjwhaU1IQjIDMc+yYqa4SH+cGjIZYBxQjCvXlNYmkt7ZfD6Kvr+pw568n
         oZ8+WDE0P7mkJkecF25YS0xg6PenN1ntEpWUOe/On6KosAGEWOPLDTvvc3gduFGZOB/b
         dAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710796879; x=1711401679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIxUkrf6TpjzqxMTzKqkU226vSY1+JGwyYdxIRGHbw0=;
        b=i6j41YLDFHkLht4mFuON69zQJPpPj6u/vJM2zZIZOCWDUsf/UUzrJ/N4vyREFFM3ML
         az0EJztAFwmQL7rpgKsjFc+goooT+uGewiJZmVUBEVLm++WXVL/LoOvFaXs8W6Y+N+ck
         gfl6hhb9JQgKPIkDfu1y11B5sViSqsHMU+KfLYgTm+GAK4r8ejKQir4FVuWVAwQfHJ0s
         0faSPLsMiejdnkTfJT+tecag6RxKobFGMV8OjHL5uajKTOJWLCEwHxT2xP7gV2MzKJso
         bXEtoRjkVw30ebefC/13WUo9qn5Vhx89Ns0vVOLyduYGoKIkTpsTRsgdUKNxSb+6n+ej
         M02Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5pu3f8QhkWNPy/K9GTHfCfZ4ZURH/9hPttprRtgndXvx8KIRNZvZmkvoeriBJ/Oo3wM6lt+3hP1gLBJmGJJt/2Z9Au1hEAsX2
X-Gm-Message-State: AOJu0YzeHULIBLgzaURjmVtpID+LgOdYjr3rGgKDXN8DpXWbvJqEIF1h
	i74AYoZqXpfaP4g7RDiwGVxIxLm2vMo9Ryo5rTGzy1y1Pmhg44gd
X-Google-Smtp-Source: AGHT+IFrxu848WJHdAxUJwoNokRb+qxTEIwz3ZJetnPDMrsVU0E9g36rjI+kJZUI9tb7SnQYTSkhrA==
X-Received: by 2002:a81:8402:0:b0:60c:bda8:cd7c with SMTP id u2-20020a818402000000b0060cbda8cd7cmr12574063ywf.10.1710796878623;
        Mon, 18 Mar 2024 14:21:18 -0700 (PDT)
Received: from debian ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id ce1-20020a05690c098100b00609fc2bd948sm2056568ywb.79.2024.03.18.14.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 14:21:18 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Mon, 18 Mar 2024 14:21:01 -0700
To: alison.schofield@intel.com
Cc: Vishal Verma <vishal.l.verma@intel.com>, nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org
Subject: Re: [ndctl PATCH v11 4/7] cxl/event_trace: add helpers to retrieve
 tep fields by type
Message-ID: <ZfiwPSAw6b1SUatU@debian>
References: <cover.1710386468.git.alison.schofield@intel.com>
 <0dbf9557aaf5e8047440cb74f7df84ae404c11ba.1710386468.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dbf9557aaf5e8047440cb74f7df84ae404c11ba.1710386468.git.alison.schofield@intel.com>

On Wed, Mar 13, 2024 at 09:05:20PM -0700, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Add helpers to extract the value of an event record field given the
> field name. This is useful when the user knows the name and format
> of the field and simply needs to get it. The helpers also return
> the 'type'_MAX of the type when the field is
> 
> Since this is in preparation for adding a cxl_poison private parser
> for 'cxl list --media-errors' support those specific required
> types: u8, u32, u64.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  cxl/event_trace.c | 37 +++++++++++++++++++++++++++++++++++++
>  cxl/event_trace.h |  8 +++++++-
>  2 files changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/cxl/event_trace.c b/cxl/event_trace.c
> index 640abdab67bf..324edb982888 100644
> --- a/cxl/event_trace.c
> +++ b/cxl/event_trace.c
> @@ -15,6 +15,43 @@
>  #define _GNU_SOURCE
>  #include <string.h>
>  
> +u64 cxl_get_field_u64(struct tep_event *event, struct tep_record *record,
> +		      const char *name)
> +{
> +	unsigned long long val;
> +
> +	if (tep_get_field_val(NULL, event, name, record, &val, 0))
> +		return ULLONG_MAX;
> +
> +	return val;
> +}
> +
> +u32 cxl_get_field_u32(struct tep_event *event, struct tep_record *record,
> +		      const char *name)
> +{
> +	char *val;
> +	int len;
> +
> +	val = tep_get_field_raw(NULL, event, name, record, &len, 0);
> +	if (!val)
> +		return UINT_MAX;
> +
> +	return *(u32 *)val;
> +}
> +
> +u8 cxl_get_field_u8(struct tep_event *event, struct tep_record *record,
> +		    const char *name)
> +{
> +	char *val;
> +	int len;
> +
> +	val = tep_get_field_raw(NULL, event, name, record, &len, 0);
> +	if (!val)
> +		return UCHAR_MAX;
> +
> +	return *(u8 *)val;
> +}
> +
>  static struct json_object *num_to_json(void *num, int elem_size, unsigned long flags)
>  {
>  	bool sign = flags & TEP_FIELD_IS_SIGNED;
> diff --git a/cxl/event_trace.h b/cxl/event_trace.h
> index b77cafb410c4..7b30c3922aef 100644
> --- a/cxl/event_trace.h
> +++ b/cxl/event_trace.h
> @@ -5,6 +5,7 @@
>  
>  #include <json-c/json.h>
>  #include <ccan/list/list.h>
> +#include <ccan/short_types/short_types.h>
>  
>  struct jlist_node {
>  	struct json_object *jobj;
> @@ -32,5 +33,10 @@ int cxl_parse_events(struct tracefs_instance *inst, struct event_ctx *ectx);
>  int cxl_event_tracing_enable(struct tracefs_instance *inst, const char *system,
>  		const char *event);
>  int cxl_event_tracing_disable(struct tracefs_instance *inst);
> -
> +u8 cxl_get_field_u8(struct tep_event *event, struct tep_record *record,
> +		    const char *name);
> +u32 cxl_get_field_u32(struct tep_event *event, struct tep_record *record,
> +		      const char *name);
> +u64 cxl_get_field_u64(struct tep_event *event, struct tep_record *record,
> +		      const char *name);
>  #endif
> -- 
> 2.37.3
> 
