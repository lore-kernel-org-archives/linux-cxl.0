Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F991136991
	for <linux-cxl@vger.kernel.org>; Tue, 27 Feb 2024 10:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709030355; cv=none; b=nSM6ySkmzTgJoJI1WcDOPuHtNLdNX4moRJX8bKV0d9Qijd7mw+gm+DLGPDiRfeTb9b2j2TIPUuOaLxf8OuRyueNeU5Lxy8z91QRQYTpCYjSw1EVOrXhqwPD1a+K2pax2eniNES7QfRexN+mZIOhI7rRsJlgli4hyxLv79SOR9ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709030355; c=relaxed/simple;
	bh=dbQh7IuciSYz+i1M0tr3D7rUkpPQtX3HVlNcjR6AkjI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=alsVa3iTymjw3823FyG3/nanB0oJIntK+2R+DAUGtWUBAjb9r2CRTfwKVzmmi4eO9hvjv0BtJNBR5FlKwoQN6i0RB0pPGpWTLVhqG68ViiA5W976SdqfzP5pNjNgFYT9/q7VynQ7xWNic1KaN1reJZVqfSJjlo56DPHGcDfz5PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TkYlx5dHPz6K6f2;
	Tue, 27 Feb 2024 18:35:25 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 51CD1140D26;
	Tue, 27 Feb 2024 18:39:10 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 27 Feb
 2024 10:39:09 +0000
Date: Tue, 27 Feb 2024 10:39:09 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: fan <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<gregory.price@memverge.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
	<nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>, Fan Ni
	<fan.ni@samsung.com>
Subject: Re: [PATCH v4 08/10] hw/cxl/cxl-mailbox-utils: Add mailbox commands
 to support add/release dynamic capacity response
Message-ID: <20240227103909.00002a92@Huawei.com>
In-Reply-To: <Zd00YhCejwN6NuU6@debian>
References: <20240221182020.1086096-1-nifan.cxl@gmail.com>
	<20240221182020.1086096-9-nifan.cxl@gmail.com>
	<20240226180417.00004dc4@Huawei.com>
	<Zd00YhCejwN6NuU6@debian>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 26 Feb 2024 17:01:22 -0800
fan <nifan.cxl@gmail.com> wrote:

> On Mon, Feb 26, 2024 at 06:04:17PM +0000, Jonathan Cameron wrote:
> > On Wed, 21 Feb 2024 10:16:01 -0800
> > nifan.cxl@gmail.com wrote:
> >   
> > > From: Fan Ni <fan.ni@samsung.com>
> > > 
> > > Per CXL spec 3.1, two mailbox commands are implemented:
> > > Add Dynamic Capacity Response (Opcode 4802h) 8.2.9.9.9.3, and
> > > Release Dynamic Capacity (Opcode 4803h) 8.2.9.9.9.4.
> > > 
> > > Signed-off-by: Fan Ni <fan.ni@samsung.com>  
> > 
> > Hi Fan, 
> > 
> > Comments on this are all about corner cases. If we can I think we need
> > to cover a few more.  Linux won't hit them (I think) so it will be
> > a bit of a pain to test but maybe raw commands enabled and some
> > userspace code will let us exercise the corner cases?
> > 
> > Jonathan
> > 
> > 
> >   
> > > +
> > > +/*
> > > + * CXL r3.1 section 8.2.9.9.9.4: Release Dynamic Capacity (opcode 4803h)
> > > + */
> > > +static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
> > > +                                          uint8_t *payload_in,
> > > +                                          size_t len_in,
> > > +                                          uint8_t *payload_out,
> > > +                                          size_t *len_out,
> > > +                                          CXLCCI *cci)
> > > +{
> > > +    CXLUpdateDCExtentListInPl *in = (void *)payload_in;
> > > +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> > > +    CXLDCExtentList *extent_list = &ct3d->dc.extents;
> > > +    CXLDCExtent *ent;
> > > +    uint32_t i;
> > > +    uint64_t dpa, len;
> > > +    CXLRetCode ret;
> > > +
> > > +    if (in->num_entries_updated == 0) {
> > > +        return CXL_MBOX_INVALID_INPUT;
> > > +    }
> > > +
> > > +    ret = cxl_detect_malformed_extent_list(ct3d, in);
> > > +    if (ret != CXL_MBOX_SUCCESS) {
> > > +        return ret;
> > > +    }
> > > +
> > > +    for (i = 0; i < in->num_entries_updated; i++) {
> > > +        bool found = false;
> > > +
> > > +        dpa = in->updated_entries[i].start_dpa;
> > > +        len = in->updated_entries[i].len;
> > > +
> > > +        QTAILQ_FOREACH(ent, extent_list, node) {
> > > +            if (ent->start_dpa <= dpa &&
> > > +                dpa + len <= ent->start_dpa + ent->len) {
> > > +                /*
> > > +                 * If an incoming extent covers a portion of an extent
> > > +                 * in the device extent list, remove only the overlapping
> > > +                 * portion, meaning
> > > +                 * 1. the portions that are not covered by the incoming
> > > +                 *    extent at both end of the original extent will become
> > > +                 *    new extents and inserted to the extent list; and
> > > +                 * 2. the original extent is removed from the extent list;
> > > +                 * 3. dc extent count is updated accordingly.
> > > +                 */
> > > +                uint64_t ent_start_dpa = ent->start_dpa;
> > > +                uint64_t ent_len = ent->len;
> > > +                uint64_t len1 = dpa - ent_start_dpa;
> > > +                uint64_t len2 = ent_start_dpa + ent_len - dpa - len;
> > > +
> > > +                found = true;
> > > +                cxl_remove_extent_from_extent_list(extent_list, ent);
> > > +                ct3d->dc.total_extent_count -= 1;
> > > +
> > > +                if (len1) {
> > > +                    cxl_insert_extent_to_extent_list(extent_list,
> > > +                                                     ent_start_dpa, len1,
> > > +                                                     NULL, 0);
> > > +                    ct3d->dc.total_extent_count += 1;
> > > +                }
> > > +                if (len2) {
> > > +                    cxl_insert_extent_to_extent_list(extent_list, dpa + len,
> > > +                                                     len2, NULL, 0);
> > > +                    ct3d->dc.total_extent_count += 1;  
> > 
> > There is a non zero chance that we'll overflow however many extents we claim
> > to support. So we need to check that and fail the remove if it happens.
> > Could ignore this for now though as that value is (I think!) conservative
> > to allow for complex extent list tracking implementations.  Succeeding
> > when a naive solution would fail due to running out of extents that it can
> > manage is not (I think) a bug.  
> 
> Yeah. spec r3.1 mentioned about the overflow issue that adding/releasing
> extent requests can raise. We should fail the operation if running out of
> extents and report resource exhausted.
> 
> >   
> > > +                }
> > > +                break;
> > > +                /*Currently we reject the attempt to remove a superset*/  
> > 
> > Space after /* and before */
> > 
> > I think we need to fix this. Linux isn't going to do it any time soon, but
> > I think it's allowed to allocate two extents next to each other then free them
> > in one go.  Isn't this case easy to do or are there awkward corners?
> > If it's sufficiently nasty (maybe because only part of extent provided exists?)
> > then maybe we can leave it for now.
> > 
> > I worry about something like
> > 
> > |  EXTENT TO FREE                                        |
> > | Exists    |   gap   | Exists                           |
> > Where we have to check for gap before removing anything?
> > Does the spec address this? Not that I can find.
> > I think the implication is we have to do a validation pass, then a free
> > pass after we know whole of requested extent is valid.
> > Nasty to test if nothing else :(  Would look much like your check
> > on malformed extent lists.
> >   
> 
> I cannot find anything specific to this in the specification either.
> Since we have already detected the case where the extent range across
> multiple regions, the only case we need to capture here is one/multiple
> portions of an extents getting released and causing extent overflow.
> I think we can handle it after we introduce the bitmaps (PATCH 10) which
> indicates DPA ranges mapped by valid extents in the device.
> 
> With that, The release workflow would be
> 
> 1) detecting malformed extent lists; if passed
> 2) do cxl_detect_extent_overflow {
>     delta = 0;
>     make a copy of the bitmap as bitmap_copy;
>     for each extent in the updated_extent_list; do
>         if (extent range not fully set in the bitmap_copy)
>             return error;
>         else {
>             if gap at the front based on the bitmap_copy:
>                 delta += 1;
>             if gap at the end based on the bitmap_copy:
>                 delta += 1;
>             delta -= 1;
>             // NOTE: current_extent_count will not be updated in the
>             // loop since delta will track the whole loop
>             if (delta + current_extent_count > max_extent_count)
>                 return resource exhausted;
>             update bitmap_copy to clear the range covered by the extent
>             under consideration;
>         }
>     done
> 
> }; if pass
> 3. do real release: in the pass, we will not need to detect extent
> errors;
> 
> Does the above solution sound reasonable? If so, do we want to go this
> way? do we need to introduce the bitmap earlier in the series?

Yes, something along these lines should work nicely.

Jonathan


> 
> Thanks,
> Fan
> 
> 
> 
> >   
> > > +            } else if ((dpa < ent->start_dpa + ent->len &&
> > > +                        dpa + len > ent->start_dpa + ent->len) ||
> > > +                       (dpa < ent->start_dpa && dpa + len > ent->start_dpa)) {
> > > +                return CXL_MBOX_INVALID_EXTENT_LIST;
> > > +            }
> > > +        }
> > > +
> > > +        if (!found) {
> > > +            /* Try to remove a non-existing extent */
> > > +            return CXL_MBOX_INVALID_PA;
> > > +        }
> > > +    }
> > > +
> > > +    return CXL_MBOX_SUCCESS;
> > > +}  
> > 
> >   

