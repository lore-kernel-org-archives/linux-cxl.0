Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77654263F44
	for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 17:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747761505; cv=none; b=FQIrqZEB6kHIgE7zgEgoni0bDBWSHR+lLEGRDZjcPDFxWC6KEIHELsaBhjuvnonMZ3aGpzzUZzKl8wdJ/66J572Nn4h2ge4HFnsObtEhlVpfCQvnzEmlcvxfnKxhjTiXk0YSsJ0XPSkcSbxMygradIYFOKSFpWEfkTlck4G3K8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747761505; c=relaxed/simple;
	bh=oKCAjP/1wIGkyiETbz3v+fzX6WndYhLg1qU22+Iycqg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9OUEdRztQjVOhdJsRoDUY5qYBA8AGFvgQJ5wbvNE9rLEriUcR6SwDZwB765+zFKnVj9QDGNpIXRQjenxq2QCMiM7lKQO91QUpII6JEuGCfye4kBqMM/goO7I9JpoW+l6y5n37m1cn5/+0Y4TMcq8emQZRFeg8lNZhABNQ8ORWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RDRPWEVB; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDRPWEVB"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-74267c68c11so5131640b3a.0
        for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 10:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747761503; x=1748366303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WHRuLt0uKLk3Rne5lNMYRtlHU9xfOLNLxmkhdwAs/4g=;
        b=RDRPWEVBu1HUMOvH+FdxfZ3QfBi/x1YFaQiIXMM8uQgPsHEzwHl46AR0GiYghwtWiP
         EXwP7AC7j4PJmF4g2nysEbMZPkDbbJwlkRVuoLVeWWSwfHAXHl0NgaGoxd1q0rCdhHGM
         6Cdgk+K2SSsmHG1UoUH/NEmz8nZk6D6gIxLlQzGylNhlEYkM7tPbXj0AVJ+tO7+tf7rE
         DaUyqBxjAjQu7E55NHXsNqX1UVrbtpSRFSJZdcN5zdEAfpKUnOF3L7m8ZKmJ2ZMyZOrU
         Dq8JMhV2klNEFoEpM/n/he9Ips6yiifbBTmAjh8a1lVxNGiIictPrq4EA2TlPFpQYswS
         8mtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747761503; x=1748366303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHRuLt0uKLk3Rne5lNMYRtlHU9xfOLNLxmkhdwAs/4g=;
        b=ZCBV3QaseFzOaJPaxZAGOFS+FtN+QTclB+HP4+zVwO8r/VTM2gjePVYoPWnQBTQmDF
         FvH8YrIDRi6W724eyF5CBpZcf4sz565U9GXgtXJQAnMIHrHvY5FrdAspo6kn2/+7nKew
         DzpbmsqAaquK4uFS23siC81fPCC4kfKoDviO2QQqpz0jXnJGB54DmvtE1dOH1SRugKbg
         sB3cww/WBH0/+Zk1Wg9x17u/RVUo2pA35h5b+mLh2Xi7ni44RmOHmcINRbK59xEc8zcT
         BxnWsHpCEXQPnD2d87UD4Iw/irlWujyIyaBM9tl6PXNdFtOGSuqapx+ZfuwCx74753Io
         K6EA==
X-Forwarded-Encrypted: i=1; AJvYcCWE09YkNHQWlw/qX2vj88hFmO83si/fA98l8B2jO5lr8GWU1oQZMBsac8K4H0/XbwyyrgtWZn8wv9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSNhlixFTrWhyQXjiOqKzrUNzYXTsJ0xXkPawri9dBkWZJVu+/
	JIBsJo+7qDq2+4+T3iz/itIyMn+JzJSUbyBa8CFyPTOvydnKDplSqTht
X-Gm-Gg: ASbGncul6XqBnmIuqoiKSEBdy/geKqvjijrz8roiUIuuN1vWLH7Jr9xi7McZcj/fa3Q
	kSBAr3AScbHStpRQITHxChH2Ke+OTkgykl1L9Zhh8DIDrXTwDoKgi08gAYPjXaPptV8rJrJJoZz
	aTmEUYEyou7sPMXUAaLD5ZDaD1jrMd8vqCz6JTy3ZBxSnSEe/XTcXQoRCAAJudxhNpTpVbmTvHh
	DrJGakaBSncJIP0Uoa4R3UZOhhgHldbJu7uN3TGOgErRBHsbnl+YvlreYAgwrbaUoK9s56vCvDt
	J9cwLIkY4oHdKP7+Rsx0t/Tab41G6Adam58rwFnWVQ==
X-Google-Smtp-Source: AGHT+IEctpiI1b8xjCQw29kS9/gOk5u9HHcNs6F4R53OPn52CJSeYZxVBSumexGTOGHE18YzMnuB3w==
X-Received: by 2002:a05:6a00:391a:b0:734:b136:9c39 with SMTP id d2e1a72fcca58-742acd509f2mr22687459b3a.19.1747761502653;
        Tue, 20 May 2025 10:18:22 -0700 (PDT)
Received: from lg ([2601:646:8f03:9fee:2c89:c0cf:1cbd:96d3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9829b9dsm8159736b3a.88.2025.05.20.10.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 10:18:22 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 20 May 2025 10:18:20 -0700
To: anisa.su887@gmail.com
Cc: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com,
	dave@stgolabs.net, linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH v2 08/10] cxl-mailbox-utils: 0x5603 - FMAPI Get DC Region
 Extent Lists
Message-ID: <aCy5XLlc81t0BdVp@lg>
References: <20250508001754.122180-1-anisa.su887@gmail.com>
 <20250508001754.122180-9-anisa.su887@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508001754.122180-9-anisa.su887@gmail.com>

On Thu, May 08, 2025 at 12:01:04AM +0000, anisa.su887@gmail.com wrote:
> From: Anisa Su <anisa.su@samsung.com>
> 
> FM DCD Management command 0x5603 implemented per CXL r3.2 Spec Section 7.6.7.6.4
> Very similar to previously implemented command 0x4801.
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
>  hw/cxl/cxl-mailbox-utils.c   | 75 ++++++++++++++++++++++++++++++++++++
>  include/hw/cxl/cxl_opcodes.h |  1 +
>  2 files changed, 76 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index fe38a13f71..a897a34ef9 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -3516,6 +3516,79 @@ static CXLRetCode cmd_fm_set_dc_region_config(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +/* CXL r3.2 section 7.6.7.6.4 Get DC Region Extent Lists (Opcode 5603h) */
> +static CXLRetCode cmd_fm_get_dc_region_extent_list(const struct cxl_cmd *cmd,
> +                                                   uint8_t *payload_in,
> +                                                   size_t len_in,
> +                                                   uint8_t *payload_out,
> +                                                   size_t *len_out,
> +                                                   CXLCCI *cci)
> +{
> +    struct {
> +        uint16_t host_id;
> +        uint8_t rsvd[2];
> +        uint32_t extent_cnt;
> +        uint32_t start_extent_id;
> +    } QEMU_PACKED *in = (void *)payload_in;
> +    struct {
> +        uint16_t host_id;
> +        uint8_t rsvd[2];
> +        uint32_t start_extent_id;
> +        uint32_t extents_returned;
> +        uint32_t total_extents;
> +        uint32_t list_generation_num;
> +        uint8_t rsvd2[4];
> +        CXLDCExtentRaw records[];
> +    } QEMU_PACKED *out = (void *)payload_out;
> +    QEMU_BUILD_BUG_ON(sizeof(*in) != 0xc);
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    CXLDCExtent *ent;
> +    CXLDCExtentRaw *out_rec;
> +    uint16_t record_count = 0, record_done = 0, i = 0;
> +    uint16_t out_pl_len, max_size;
> +
> +    if (in->host_id != 0) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    if (in->start_extent_id > ct3d->dc.total_extent_count) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    record_count = MIN(in->extent_cnt,
> +                       ct3d->dc.total_extent_count - in->start_extent_id);
> +    max_size = CXL_MAILBOX_MAX_PAYLOAD_SIZE - sizeof(*out);
> +    record_count = MIN(record_count, max_size / sizeof(out->records[0]));
> +    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
> +
> +    stw_le_p(&out->host_id, in->host_id);
> +    stl_le_p(&out->start_extent_id, in->start_extent_id);
> +    stl_le_p(&out->extents_returned, record_count);
> +    stl_le_p(&out->total_extents, ct3d->dc.total_extent_count);
> +    stl_le_p(&out->list_generation_num, ct3d->dc.ext_list_gen_seq);
> +
> +    if (record_count > 0) {
> +        QTAILQ_FOREACH(ent, &ct3d->dc.extents, node) {
> +            if (i++ < in->start_extent_id) {
> +                continue;
> +            }
> +            out_rec = &out->records[record_done];
> +            stq_le_p(&out_rec->start_dpa, ent->start_dpa);
> +            stq_le_p(&out_rec->len, ent->len);
> +            memcpy(&out_rec->tag, ent->tag, 0x10);
> +            stw_le_p(&out_rec->shared_seq, ent->shared_seq);
> +
> +            record_done++;
> +            if (record_done == record_count) {
> +                break;
> +            }
> +        }
> +    }
> +
> +    *len_out = out_pl_len;
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  static const struct cxl_cmd cxl_cmd_set[256][256] = {
>      [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
>          cmd_infostat_bg_op_abort, 0, 0 },
> @@ -3649,6 +3722,8 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
>           CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
>           CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
>           CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
> +    [FMAPI_DCD_MGMT][GET_DC_REGION_EXTENT_LIST] = { "GET_DC_REGION_EXTENT_LIST",
> +        cmd_fm_get_dc_region_extent_list, 12, 0 },
>  };
>  
>  /*
> diff --git a/include/hw/cxl/cxl_opcodes.h b/include/hw/cxl/cxl_opcodes.h
> index ed4be23b75..ad4e614daa 100644
> --- a/include/hw/cxl/cxl_opcodes.h
> +++ b/include/hw/cxl/cxl_opcodes.h
> @@ -65,5 +65,6 @@ enum {
>          #define GET_DCD_INFO 0x0
>          #define GET_HOST_DC_REGION_CONFIG 0x1
>          #define SET_DC_REGION_CONFIG 0x2
> +        #define GET_DC_REGION_EXTENT_LIST 0x3
>      GLOBAL_MEMORY_ACCESS_EP_MGMT = 0X59
>  };
> -- 
> 2.47.2
> 

-- 
Fan Ni
