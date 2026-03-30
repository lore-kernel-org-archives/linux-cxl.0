Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503BE27B353
	for <linux-cxl@vger.kernel.org>; Mon, 30 Mar 2026 18:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774893796; cv=none; b=LQtDJgM+UVyFl6fbi4gtgv4EW25N9ajndjk3lclgHGs5b88WZxFPhcnwyMDg4Kw/sGZvMtN0daX1t/KGirDooV9LOjnz2uclbS5LPzISv/Sj/Q8yLNRZGam996RYx//9AJdMwjn6CMC32Y5a7Ti7qJYeGpnaMPrgTXT5ZeU80y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774893796; c=relaxed/simple;
	bh=84VxzTi8gJchRq/HGSqGqIhjxZgEcDhVi4cyDMPCAIU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PfditCuhvp8yiyuI3nrqaOMTdtp0lFINHNJESOeMCUVJ6nvt2jn7ijzog0I6wqkOYwKoNZXE841eSu1jx+wnFWHs7hekW/tXwRRLTxRh8K57FgW+gdSw0uWHshJaXCZRN2tr2EWz0eaV58NV9d4DJp8EUoOfirMgGnMIg8lvyNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NT8NuyqO; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NT8NuyqO"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6500eae6d2fso3837593d50.1
        for <linux-cxl@vger.kernel.org>; Mon, 30 Mar 2026 11:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774893794; x=1775498594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VSSej4rQP/km8NEhv3cfELxnfJmGjoS8RTsivRF4Ji8=;
        b=NT8NuyqOf330TjpRf1FILt8wcG+BrAh3a0VtgqTAXdt4SgWl3ABe2Zp9PKf3bczv/W
         yVy9qkUdX1KyO7ihN2zaYB6syL4/iQwa9J9GlCH4IvLdOoeQYBGlwzv8Fb3eiEd9AK+y
         L6Dksq861UFdLJBvT5Ae8NWOKS5vNF3y891RLBiw3m3huHaOkVNRQEmvVwYi2lf257Nm
         FXmf3jtIBnSc7zdYx2RZ+pFlzV2VUTZI43K1rRgCNPbyix6YRPWM16A/8/XMe/PKkhdQ
         7KGoycimpWCl83QB4d20uolqL+ZxNx2sItztNDcJgScNBYaVHqmTzVjZF7Ss8Qa5/GvO
         kX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774893794; x=1775498594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VSSej4rQP/km8NEhv3cfELxnfJmGjoS8RTsivRF4Ji8=;
        b=HTM9ZUMeagFUGlHISWhsNJy8oc+cXjIn+fMrnX9POZZgYd8yun3ltZll73KB5hnTgU
         fj+/5U1TmF8ILbH7Fm9ljrHWD6Ssv99QjcMzgCJLUgB+Ujs2qNK5m79elABH6DVX3kGW
         JtK1nqMXUy7TCZ4HcsZrd4QO7hLj/O8ipwSZu64DlZ1p66r1sOR42uaYvtojvTaYhSvs
         Ta3gUF4nTanL96drbiP9zYguMZ2cSoSf017t+iF/injBPMh5gpTwnbmYqS9f1ZDZi08+
         rPHeatWhV2t72Gyt59n95SBg9zlWc5FiaYzxvdI075Wj7+EAZ7gej2jsoSBEpEMwn7gG
         z1wQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSyoHiorsA2rW5gOjUWqMfotkSTl41DM3dTwwCkta1EsAMcv7/avu/K9dCkRk2QWy2OQNWsRuNksU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8PAJiskC1Je6P6OKdwm4MhmzosLwoPuJ/x790mQAlTadvMThF
	f+m02W+Zx2VztxoRe+yf9Ss8vPkPKWJUCAPdz7vcuxAEOAW5XYTXrcCs
X-Gm-Gg: ATEYQzxnaVjj/vKtB7zwrF/vV96KJ/e/W5IO8Oz2nd4IBxZxhG8wrV07DeJS2l9WgRO
	7AIDpCftPMiX92aoyKM1+CEGCJTPMHtgnaDtS5UKfko5htx5IBXXd9tm8DNwundkwh+MJeym3lv
	xmhhUt8ERwEhqWmrw/WJVOc1BlrHZonfnmg8Ttu7veVl1F+k+ait0OhqxkZcno8hgynWTkrY0XE
	/5Wg+35VLQ6X6r18+tRo7q60WcyAvT69dZMvfMFqicl3VvUqdCg1PobawpC+KZxLlXWp0R27rbg
	LcfOzWweJFUoPiVxUJ6+AoMkV81t+8JYLknC1uUN/qw38Pbv5qRh9WY+WRzeQ8rmOu+iKLYsfDb
	EXm4xlK3W3Yf63XKuuuDjiHqCcKht1jUapVTcIKlKib4Eeu/LTGbXHnESsXRGs5IOeG2hqm9q5G
	gJ0V838XVHXKhv0ckC9eaIoPA9Bb4UGVyIdMTFxd034A==
X-Received: by 2002:a05:690c:6a10:b0:796:5a14:87c6 with SMTP id 00721157ae682-79bddcd9a75mr136950247b3.4.1774893794063;
        Mon, 30 Mar 2026 11:03:14 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79cb7135bd2sm38243927b3.2.2026.03.30.11.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 11:03:13 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Mon, 30 Mar 2026 11:03:10 -0700
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berrange@redhat.com,
	eblake@redhat.com, jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org, linuxarm@huawei.com,
	lizhijian@fujitsu.com, mst@redhat.com, pbonzini@redhat.com,
	gourry@gourry.net, nifan.cxl@gmail.com, me@linux.beauty
Subject: Re: [PATCH 8/9] hw/cxl: Add tag-based dynamic-capacity release
 support
Message-ID: <acq63qeubIux3W0p@4470NRD-ASU.ssi.samsung.com>
References: <20260325184259.366-1-alireza.sanaee@huawei.com>
 <20260325184259.366-9-alireza.sanaee@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325184259.366-9-alireza.sanaee@huawei.com>

On Wed, Mar 25, 2026 at 06:42:56PM +0000, Alireza Sanaee wrote:
> Add support for the tag-based dynamic-capacity release policy via the QMP
> interface. The new path scans committed extents, selects those whose stored
> tag matches the requested UUID, and emits a Release Dynamic Capacity event
> for each matching range.
> 
> This is intentionally scoped to tag-driven selection. Prescriptive release
> handling and the underlying extent teardown stay in the existing paths.
> 
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> ---
>  hw/mem/cxl_type3.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 6b73d58358..d5fa8a530a 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -2492,6 +2492,63 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
>      cxl_create_dc_event_records_for_extents(dcd, type, extents, num_extents);
>  }
>  
> +static void qmp_cxl_process_dynamic_capacity_tag_based(const char *path,
> +        uint16_t hid, CXLDCEventType type, uint8_t rid, const char *tag,
> +        CxlDynamicCapacityExtentList *records, Error **errp)
> +{
> +    Object *obj;
> +    CXLType3Dev *dcd;
> +    CXLDCExtentList *list = NULL;
> +    CXLDCExtent *ent;
> +    g_autofree CXLDCExtentRaw *extents = NULL;
> +
> +    obj = object_resolve_path_type(path, TYPE_CXL_TYPE3, NULL);
> +    if (!obj) {
> +        error_setg(errp, "Unable to resolve CXL type 3 device");
> +        return;
> +    }
> +
> +    dcd = CXL_TYPE3(obj);
> +    if (!dcd->dc.num_regions) {
> +        error_setg(errp, "No dynamic capacity support from the device");
> +        return;
> +    }
> +
> +    if (rid >= dcd->dc.num_regions) {
> +        error_setg(errp, "region id is too large");
> +        return;
> +    }
> +
> +    QemuUUID uuid_req;
> +    qemu_uuid_parse(tag, &uuid_req);
> +
> +    list = &dcd->dc.extents;
> +    size_t cap = 8, n = 0;
> +    extents = g_new0(CXLDCExtentRaw, cap);
> +    QTAILQ_FOREACH(ent, list, node) {
> +        QemuUUID uuid_ext;
> +        memcpy(&uuid_ext.data, ent->tag, sizeof(ent->tag));
> +        if (!qemu_uuid_is_equal(&uuid_req, &uuid_ext)) {
> +            continue;
> +        }
> +
> +        if (n == cap) {
> +            cap *= 2;
> +            extents = g_renew(CXLDCExtentRaw, extents, cap);
> +        }
> +
> +        extents[n++] = (CXLDCExtentRaw){ .start_dpa = ent->start_dpa,
> +                                         .len = ent->len,
> +                                         .shared_seq = 0 };
	extents[n] = (CXLDCExtentRaw){ .start_dpa = ent->start_dpa,
                                       .len = ent->len,
                                       .shared_seq = 0 };
        memcpy(extents[n].tag, uuid_ext.data, 0x10);
        n++;

That should fix the issue I was talking about earlier in the other thread haha
(I tested it this time)
> +    }
> +
> +    if (n == 0) {
> +        return;
> +    }
> +    extents = g_renew(CXLDCExtentRaw, extents, n);
> +    cxl_create_dc_event_records_for_extents(dcd, type, extents, n);
> +}
> +
>  void qmp_cxl_add_dynamic_capacity(const char *path, uint16_t host_id,
>                                    CxlExtentSelectionPolicy sel_policy,
>                                    uint8_t region, const char *tag,
> @@ -2537,6 +2594,10 @@ void qmp_cxl_release_dynamic_capacity(const char *path, uint16_t host_id,
>                                                        region, tag,
>                                                        extents, errp);
>          return;
> +    case CXL_EXTENT_REMOVAL_POLICY_TAG_BASED:
> +        qmp_cxl_process_dynamic_capacity_tag_based(path, host_id, type, region,
> +                                                   tag, extents, errp);
> +        return;
>      default:
>          error_setg(errp, "Removal policy not supported");
>          return;
> -- 
> 2.50.1 (Apple Git-155)
> 
