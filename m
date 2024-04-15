Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A546371B50
	for <linux-cxl@vger.kernel.org>; Mon, 15 Apr 2024 20:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713212277; cv=none; b=JNcLLSYc+yQDBWMHrVog+A+mq9X2QZ+Oc74QBeZQ+NSe1ac8OLp5B9OSlAqdw0UVz2IMUuAb7W1eDCz4aPhdP2aSyJQV6dP1Hez7AC+pR+hOfuR+TU5xlIdBU9OXneQEcEbQfRlrmr1pFUNr7j47r79fQCnFjapq7OCULRuNO8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713212277; c=relaxed/simple;
	bh=cexFG+Z6coB+6WAB6iQRJ4kfAz4ZtV8w4O8uR4cSLT4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HdPzyP9w5cCc4iRMT9MWpEFatSORHDChxhXQPFEZPs+7lX/vOsmJHzFJJHVNB4O1iC9oK/XXzHAWbRsmCsZxnv0coiOCvKL9SFNCYAW4VSN2PjennKP5Jj/PE4RQYVEFUrXeRYn81hnRK4CPkXmn5tB8RPb6KORUi/6SjnV8s/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXwh0CWw; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXwh0CWw"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-61ac45807cbso14091587b3.1
        for <linux-cxl@vger.kernel.org>; Mon, 15 Apr 2024 13:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713212274; x=1713817074; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iNGKDtAQC3/lbSG2tuDR4D0iHAkKD8O4uN3Wu2w8GYg=;
        b=AXwh0CWwuKszKwV5aFUo+Xlq51ip8HvfxElQ6ZKRgUC/vk7E0wdbnrl0jMNTilHLLB
         LowBZGJWUjwqlGmNY6vjcmsUiX4F0RLyf/dyRWIKZvYkEqvgaf3Z+oj5f2w58O6+Y80D
         B6Yqv8DNLvijIMTOLdx0ewCnWDfTF5imC7jeEOURwK6axoaW2siirPc6DlmlGamBMIWm
         RociMJTlKwUGeAvadxPt+Fkd9tB6VW2ZGn48HzInEShkewEaZ+T6uuT2FxOYP4Q77VUD
         xeB3VbxW99tmu8MUdvqEBr0KL14LxVQ5+RyEloMLcVuUrc5zwEJwn5+OwgYScJkKQXMy
         ZRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713212274; x=1713817074;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iNGKDtAQC3/lbSG2tuDR4D0iHAkKD8O4uN3Wu2w8GYg=;
        b=Gdf6KLbBNy3Guer4g8GRiyxrBIOC3Q64LNJ7wRtkStGpEPVbG9RcVf+xqA4zaeuQLL
         qdxxekIcAN8wNC3wc0aL0gGA+9HFz3MbyTx9awXhf7q1uOn2FBAuKY2PtFMzg5sZVohl
         KsA+EQf0+DbIwMJ+BF3nuwjUGEKj84RgHtXOsL9MFlkEkMzKQWpPGuVozn/aAePPSZdk
         agky0Bma5RLcy98VCDsTk2YoUjFY6x58JxKonCOUZRKI74n13WTEYek6ZuM00QXgFuiB
         IA6t7rG/Uj++WT1n/wfKjUHIr8cVbqcu1FePxzpZTCx2zm4MNq8CQixcseS2D+UxYxeP
         r8eA==
X-Forwarded-Encrypted: i=1; AJvYcCW9SDqJzHa3DEuYfNZNN6eDZ/K+x2zRf9SsNG9493t4hm0ByrXXkwKR+Lp6sXNYf1UyOOXy5KxOdcaBDto8Z2PNzl23PWgHrrm9
X-Gm-Message-State: AOJu0Ywo11V29R6BmS+kNlkW/g6W9Day843N92n6Z3e04ODRrPne3qkO
	oYV2jQwaDvFssEVwLaI5aBZH1x0YtOrrr+B//aulacOdOhBNt5BQ
X-Google-Smtp-Source: AGHT+IFOI0NRCr/+WD61ovmwptB3WqLUVN93cGd3e0eMGWbTxz7n9dY12dABayYCLWYHRTOu1W/bXQ==
X-Received: by 2002:a81:48cb:0:b0:61a:e565:78d1 with SMTP id v194-20020a8148cb000000b0061ae56578d1mr1894692ywa.43.1713212274634;
        Mon, 15 Apr 2024 13:17:54 -0700 (PDT)
Received: from debian ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id o1-20020a817e01000000b00614f87bd41asm2192606ywn.56.2024.04.15.13.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 13:17:54 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Mon, 15 Apr 2024 13:17:51 -0700
To: =?iso-8859-1?Q?J=F8rgen?= Hansen <Jorgen.Hansen@wdc.com>
Cc: "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"gregory.price@memverge.com" <gregory.price@memverge.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"a.manzanares@samsung.com" <a.manzanares@samsung.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>,
	"nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
	"jim.harris@samsung.com" <jim.harris@samsung.com>,
	"wj28.lee@gmail.com" <wj28.lee@gmail.com>,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v6 11/12] hw/cxl/cxl-mailbox-utils: Add superset extent
 release mailbox support
Message-ID: <Zh2Lb7LzZDwbumXp@debian>
References: <20240325190339.696686-1-nifan.cxl@gmail.com>
 <20240325190339.696686-12-nifan.cxl@gmail.com>
 <dd9318d8-7553-4dc9-9075-8645fb6e091d@wdc.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd9318d8-7553-4dc9-9075-8645fb6e091d@wdc.com>

On Fri, Apr 05, 2024 at 09:57:18AM +0000, Jørgen Hansen wrote:
> On 3/25/24 20:02, nifan.cxl@gmail.com wrote:
> > From: Fan Ni <fan.ni@samsung.com>
> > 
> > With the change, we extend the extent release mailbox command processing
> > to allow more flexible release. As long as the DPA range of the extent to
> > release is covered by accepted extent(s) in the device, the release can be
> > performed.
> > 
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > ---
> >   hw/cxl/cxl-mailbox-utils.c | 41 ++++++++++++++++++++++----------------
> >   1 file changed, 24 insertions(+), 17 deletions(-)
> > 
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index a0d2239176..3b7949c364 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -1674,6 +1674,12 @@ static CXLRetCode cxl_dc_extent_release_dry_run(CXLType3Dev *ct3d,
> >           dpa = in->updated_entries[i].start_dpa;
> >           len = in->updated_entries[i].len;
> > 
> > +        /* Check if the DPA range is not fully backed with valid extents */
> > +        if (!ct3_test_region_block_backed(ct3d, dpa, len)) {
> > +            ret = CXL_MBOX_INVALID_PA;
> > +            goto free_and_exit;
> > +        }
> 
> In cxl_dcd_add_dyn_cap_rsp_dry_run, the opposite check (all 0's in the 
> bitmap) could be used instead of looping through the full extent list 
> (and this also makes my previous comment about reusing the bitmap from 
> cxl_detect_malformed_extent_list irrelevant).

For adding, we need to make sure the incoming extents have no overlaps
with accepted extents, that means if any bit of the range is not 0, it
returns error. We cannot use !ct3_test_region_block_backed for the
purpose, as it return true when all 1s, not has 1s.

For the purpose, we need some function like
ct3_test_region_block_all_cleared or ct3_test_region_block_non_backed.
We do not have that in current code.
Checking bitmap is more performance efficient, but it introduces more
changes, so I will leave it as it is until there are more concerns.

Fan

> 
> > +        /* After this point, extent overflow is the only error can happen */
> >           while (len > 0) {
> >               QTAILQ_FOREACH(ent, &tmp_list, node) {
> >                   range_init_nofail(&range, ent->start_dpa, ent->len);
> > @@ -1713,25 +1719,27 @@ static CXLRetCode cxl_dc_extent_release_dry_run(CXLType3Dev *ct3d,
> >                               goto free_and_exit;
> >                           }
> >                       } else {
> > -                        /*
> > -                         * TODO: we reject the attempt to remove an extent
> > -                         * that overlaps with multiple extents in the device
> > -                         * for now, we will allow it once superset release
> > -                         * support is added.
> > -                         */
> > -                        ret = CXL_MBOX_INVALID_PA;
> > -                        goto free_and_exit;
> > +                        len1 = dpa - ent_start_dpa;
> > +                        len2 = 0;
> > +                        len_done = ent_len - len1 - len2;
> 
> You don't need len2 in the else statement.
> 
> Thanks,
> Jørgen
> 
> > +
> > +                        cxl_remove_extent_from_extent_list(&tmp_list, ent);
> > +                        cnt_delta--;
> > +                        if (len1) {
> > +                            cxl_insert_extent_to_extent_list(&tmp_list,
> > +                                                             ent_start_dpa,
> > +                                                             len1, NULL, 0);
> > +                            cnt_delta++;
> > +                        }
> >                       }
> > 
> >                       len -= len_done;
> > -                    /* len == 0 here until superset release is added */
> > +                    if (len) {
> > +                        dpa = ent_start_dpa + ent_len;
> > +                    }
> >                       break;
> >                   }
> >               }
> > -            if (len) {
> > -                ret = CXL_MBOX_INVALID_PA;
> > -                goto free_and_exit;
> > -            }
> >           }
> >       }
> >   free_and_exit:
> > @@ -1819,10 +1827,9 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
> >                       }
> > 
> >                       len -= len_done;
> > -                    /*
> > -                     * len will always be 0 until superset release is add.
> > -                     * TODO: superset release will be added.
> > -                     */
> > +                    if (len > 0) {
> > +                        dpa = ent_start_dpa + ent_len;
> > +                    }
> >                       break;
> >                   }
> >               }
> > --
> > 2.43.0
> > 
