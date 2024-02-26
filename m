Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E5D12DD87
	for <linux-cxl@vger.kernel.org>; Mon, 26 Feb 2024 18:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708970664; cv=none; b=IGVxnmHiSlKi8nJDTHt5AuS9H2VhSBFQsnWkoW0oSxzZQNlv6OCib2J/rbJHD38jV3m5MMxkxn3ftVdK41a/9W27ZqzUK/zoHajiD/W6Xvw/QkQOiTLfm52ek4RJHF40C4Wia1Te3rfvGff9RxGgD/+HCtF8o7VzVOKfQmc2eWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708970664; c=relaxed/simple;
	bh=19mECA62qmRRg55BPijZomn9VFD56uVmyaYqdBMS82Y=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TfKkzBeVZK+ZE+flnEtHYjJbdYGPz1ZojhtDtstejT+kuiO7M/2hLIK+UdWvtWL1+GumckDuq7uA53r/IYwn9iIsDmRZpaIdmzp38i72a3xkOlyDe+MV5wbrFikrl09YTgEv53/OYzWe65ySX7GPEPNtxXk4eKEoOjq2JCXey3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tk7g46pzmz6JBVH;
	Tue, 27 Feb 2024 01:59:44 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 3D3B6142056;
	Tue, 27 Feb 2024 02:04:19 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 26 Feb
 2024 18:04:18 +0000
Date: Mon, 26 Feb 2024 18:04:17 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<gregory.price@memverge.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
	<nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>, Fan Ni
	<fan.ni@samsung.com>
Subject: Re: [PATCH v4 08/10] hw/cxl/cxl-mailbox-utils: Add mailbox commands
 to support add/release dynamic capacity response
Message-ID: <20240226180417.00004dc4@Huawei.com>
In-Reply-To: <20240221182020.1086096-9-nifan.cxl@gmail.com>
References: <20240221182020.1086096-1-nifan.cxl@gmail.com>
	<20240221182020.1086096-9-nifan.cxl@gmail.com>
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
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 21 Feb 2024 10:16:01 -0800
nifan.cxl@gmail.com wrote:

> From: Fan Ni <fan.ni@samsung.com>
> 
> Per CXL spec 3.1, two mailbox commands are implemented:
> Add Dynamic Capacity Response (Opcode 4802h) 8.2.9.9.9.3, and
> Release Dynamic Capacity (Opcode 4803h) 8.2.9.9.9.4.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>

Hi Fan, 

Comments on this are all about corner cases. If we can I think we need
to cover a few more.  Linux won't hit them (I think) so it will be
a bit of a pain to test but maybe raw commands enabled and some
userspace code will let us exercise the corner cases?

Jonathan



> +
> +/*
> + * CXL r3.1 section 8.2.9.9.9.4: Release Dynamic Capacity (opcode 4803h)
> + */
> +static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
> +                                          uint8_t *payload_in,
> +                                          size_t len_in,
> +                                          uint8_t *payload_out,
> +                                          size_t *len_out,
> +                                          CXLCCI *cci)
> +{
> +    CXLUpdateDCExtentListInPl *in = (void *)payload_in;
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    CXLDCExtentList *extent_list = &ct3d->dc.extents;
> +    CXLDCExtent *ent;
> +    uint32_t i;
> +    uint64_t dpa, len;
> +    CXLRetCode ret;
> +
> +    if (in->num_entries_updated == 0) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    ret = cxl_detect_malformed_extent_list(ct3d, in);
> +    if (ret != CXL_MBOX_SUCCESS) {
> +        return ret;
> +    }
> +
> +    for (i = 0; i < in->num_entries_updated; i++) {
> +        bool found = false;
> +
> +        dpa = in->updated_entries[i].start_dpa;
> +        len = in->updated_entries[i].len;
> +
> +        QTAILQ_FOREACH(ent, extent_list, node) {
> +            if (ent->start_dpa <= dpa &&
> +                dpa + len <= ent->start_dpa + ent->len) {
> +                /*
> +                 * If an incoming extent covers a portion of an extent
> +                 * in the device extent list, remove only the overlapping
> +                 * portion, meaning
> +                 * 1. the portions that are not covered by the incoming
> +                 *    extent at both end of the original extent will become
> +                 *    new extents and inserted to the extent list; and
> +                 * 2. the original extent is removed from the extent list;
> +                 * 3. dc extent count is updated accordingly.
> +                 */
> +                uint64_t ent_start_dpa = ent->start_dpa;
> +                uint64_t ent_len = ent->len;
> +                uint64_t len1 = dpa - ent_start_dpa;
> +                uint64_t len2 = ent_start_dpa + ent_len - dpa - len;
> +
> +                found = true;
> +                cxl_remove_extent_from_extent_list(extent_list, ent);
> +                ct3d->dc.total_extent_count -= 1;
> +
> +                if (len1) {
> +                    cxl_insert_extent_to_extent_list(extent_list,
> +                                                     ent_start_dpa, len1,
> +                                                     NULL, 0);
> +                    ct3d->dc.total_extent_count += 1;
> +                }
> +                if (len2) {
> +                    cxl_insert_extent_to_extent_list(extent_list, dpa + len,
> +                                                     len2, NULL, 0);
> +                    ct3d->dc.total_extent_count += 1;

There is a non zero chance that we'll overflow however many extents we claim
to support. So we need to check that and fail the remove if it happens.
Could ignore this for now though as that value is (I think!) conservative
to allow for complex extent list tracking implementations.  Succeeding
when a naive solution would fail due to running out of extents that it can
manage is not (I think) a bug.

> +                }
> +                break;
> +                /*Currently we reject the attempt to remove a superset*/

Space after /* and before */

I think we need to fix this. Linux isn't going to do it any time soon, but
I think it's allowed to allocate two extents next to each other then free them
in one go.  Isn't this case easy to do or are there awkward corners?
If it's sufficiently nasty (maybe because only part of extent provided exists?)
then maybe we can leave it for now.

I worry about something like

|  EXTENT TO FREE                                        |
| Exists    |   gap   | Exists                           |
Where we have to check for gap before removing anything?
Does the spec address this? Not that I can find.
I think the implication is we have to do a validation pass, then a free
pass after we know whole of requested extent is valid.
Nasty to test if nothing else :(  Would look much like your check
on malformed extent lists.


> +            } else if ((dpa < ent->start_dpa + ent->len &&
> +                        dpa + len > ent->start_dpa + ent->len) ||
> +                       (dpa < ent->start_dpa && dpa + len > ent->start_dpa)) {
> +                return CXL_MBOX_INVALID_EXTENT_LIST;
> +            }
> +        }
> +
> +        if (!found) {
> +            /* Try to remove a non-existing extent */
> +            return CXL_MBOX_INVALID_PA;
> +        }
> +    }
> +
> +    return CXL_MBOX_SUCCESS;
> +}


