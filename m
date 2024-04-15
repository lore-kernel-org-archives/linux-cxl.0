Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23CE13AD27
	for <linux-cxl@vger.kernel.org>; Mon, 15 Apr 2024 17:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713202630; cv=none; b=VsWQEpNHd8tqR7umtMdNr4md6uBRk48nUhl9msDxSEB4bABHc71sapK6QrdCdUGZzMUIU1gnIxENCqZ9unQLu1WMbxSPCSOZLVEXcRCpBbTOV37x9NNZMIKaxI1so9HK/e2TDQ8h3QyntLW2DZx70mRODYqU8Z3+q6OoNCqueXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713202630; c=relaxed/simple;
	bh=NkfX/aMBSHZTgLFYdj2Uv0Z28s1hEGsRFDeeKpTeHmI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdsrdiFzNB3cJRJ8GK7kuoEUn3HJDBC+kZC/pH6IWaIFHEOX39WzH4isO7KkRa3aDKWXDdpLe5/rEGS+jmomDDdVCNtyBbYpyhVNbsTzmAA1P8t8/y1MckmkpdXEFv68AvPxJmptQzsHf3QvDPGqcolCgfMkBh47u8autiP4C14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kg1L5U6W; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kg1L5U6W"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dcc84ae94c1so3327743276.1
        for <linux-cxl@vger.kernel.org>; Mon, 15 Apr 2024 10:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713202628; x=1713807428; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W50oYQbiNq8ZCtSTF/Gma3PcpD6n9++jBPNY2gg7KvU=;
        b=kg1L5U6WS5zt6gJwxzTnk7MXjEsNRLpTA7I5zLTqpZidz9bonUCDqp3Hpbv41XNr+q
         +FXds7weGJJ/z1fEU5lBm5KBGA2lLflV1ij3B+z0LY2XZy++js2m4nXoc7+EBFPittH2
         GDzOekpGYnaAWdCnoMw32X69nLbbQobVaByyu9A4rXeFdBfYFMsNsBK3zY86kzv7MlyC
         MWHEDB4TsnDafuBOGeUz1+zqGjx961ju93YOCm27OCQqxI+e+WGqhqQNVuevJl+hmaSq
         18qtfCTaqe/ZhEHmAo+Gm2MkgBJMtdyCFiGPTeL655WReecil6VsXA+mJYOH+YBJc46K
         Or/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713202628; x=1713807428;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W50oYQbiNq8ZCtSTF/Gma3PcpD6n9++jBPNY2gg7KvU=;
        b=FoXcITMJ3XjCTIBPzIKa+CXg+nIOaQ5ll7FwYIerhffgVgVmFbkwr/48iwppk/2p4q
         Yp1qly6ikzIuFBaSBTKpGjENoIAo9T6Eqo3AMGSN8iqpg8GD1vnD71Nc8gozil682EcG
         pqPdqSPiPiUdWIKgDKgpECPV2F5aPVL6LNa4KTqR3E8I+I/7PqJHr3/YnEyenJSZ8B50
         +9QSsN7CNmLk2J4/nkDYFrN49lMgL5EyOUdGPUuvA3csrMSCuf3z6HC/3gB7OMUkN+MC
         2O3M2RAyVJK+rCCJ2Sw7DZ1M+2Rq33K0UjguLe6LjaDdCi/1gxD7PZ8oUd69bLx0OeZW
         jHpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfToGIyoEQsJZvyBqXOOIeZp/dzHGkxXSNiReVoHF5sOPtWGPYRwxoBCK225lofsoA0dLVhZt2+UuIH0C/zpt7xOSwPDzOgM4P
X-Gm-Message-State: AOJu0YzIc8/seFHMh3Sy4YcLyjOGmwjlkW88oI46z1LZgoL+LqHd8DzH
	e6sErtvARIftTJQXz8idfzyMQbyyqHYNHkKaugFfjvMv1bG+Rl5I
X-Google-Smtp-Source: AGHT+IHfOxIGU2OZGmtfCwLzNI4tVwvrHx+GkMPYInQfI0DJDIof/Knu9yFKEXhH2fTMMRoc3RK2xA==
X-Received: by 2002:a25:c142:0:b0:d80:68d1:b826 with SMTP id r63-20020a25c142000000b00d8068d1b826mr9871785ybf.6.1713202627699;
        Mon, 15 Apr 2024 10:37:07 -0700 (PDT)
Received: from debian ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id k12-20020a5b0a0c000000b00dcdba3056e9sm2039499ybq.25.2024.04.15.10.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 10:37:07 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Mon, 15 Apr 2024 10:37:00 -0700
To: Gregory Price <gregory.price@memverge.com>
Cc: nifan.cxl@gmail.com, qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org, ira.weiny@intel.com,
	dan.j.williams@intel.com, a.manzanares@samsung.com,
	dave@stgolabs.net, nmtadam.samsung@gmail.com,
	jim.harris@samsung.com, Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v6 10/12] hw/mem/cxl_type3: Add dpa range validation for
 accesses to DC regions
Message-ID: <Zh1lk8FWmf0oI7RM@debian>
References: <20240325190339.696686-1-nifan.cxl@gmail.com>
 <20240325190339.696686-11-nifan.cxl@gmail.com>
 <Zhm7ssKVGdGlR9Iq@memverge.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zhm7ssKVGdGlR9Iq@memverge.com>

On Fri, Apr 12, 2024 at 06:54:42PM -0400, Gregory Price wrote:
> On Mon, Mar 25, 2024 at 12:02:28PM -0700, nifan.cxl@gmail.com wrote:
> > From: Fan Ni <fan.ni@samsung.com>
> > 
> > All dpa ranges in the DC regions are invalid to access until an extent
> > covering the range has been added. Add a bitmap for each region to
> > record whether a DC block in the region has been backed by DC extent.
> > For the bitmap, a bit in the bitmap represents a DC block. When a DC
> > extent is added, all the bits of the blocks in the extent will be set,
> > which will be cleared when the extent is released.
> > 
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > ---
> >  hw/cxl/cxl-mailbox-utils.c  |  6 +++
> >  hw/mem/cxl_type3.c          | 76 +++++++++++++++++++++++++++++++++++++
> >  include/hw/cxl/cxl_device.h |  7 ++++
> >  3 files changed, 89 insertions(+)
> > 
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index 7094e007b9..a0d2239176 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -1620,6 +1620,7 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
> >  
> >          cxl_insert_extent_to_extent_list(extent_list, dpa, len, NULL, 0);
> >          ct3d->dc.total_extent_count += 1;
> > +        ct3_set_region_block_backed(ct3d, dpa, len);
> >  
> >          ent = QTAILQ_FIRST(&ct3d->dc.extents_pending);
> >          cxl_remove_extent_from_extent_list(&ct3d->dc.extents_pending, ent);
> 
> while looking at the MHD code, we had decided to "reserve" the blocks in
> the bitmap in the call to `qmp_cxl_process_dynamic_capacity` in order to
> prevent a potential double-allocation (basically we need to sanity check
> that two hosts aren't reserving the region PRIOR to the host being
> notified).
> 
> I did not see any checks in the `qmp_cxl_process_dynamic_capacity` path
> to prevent pending extents from being double-allocated.  Is this an
> explicit choice?
> 
> I can see, for example, why you may want to allow the following in the
> pending list: [Add X, Remove X, Add X].  I just want to know if this is
> intentional or not. If not, you may consider adding a pending check
> during the sanity check phase of `qmp_cxl_process_dynamic_capacity`
> 
> ~Gregory

First, for remove request, pending list is not involved. See cxl r3.1,
9.13.3.3. Pending basically means "pending to add". 
So for the above example, in the pending list, you can see [Add x, add x] if the
event is not processed in time.
Second, from the spec, I cannot find any text saying we cannot issue
another add extent X if it is still pending.
From the kernel side, if the first one is accepted, the second one will
get rejected, and there is no issue there.
If the first is reject for some reason, the second one can get
accepted or rejected and do not need to worry about the first one.


Fan

