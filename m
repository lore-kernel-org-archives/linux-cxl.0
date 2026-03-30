Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F316240DFC1
	for <linux-cxl@vger.kernel.org>; Mon, 30 Mar 2026 17:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774891109; cv=none; b=OoZi14sxQO6zahqrD1/7lA4l6E25PiUmWzbOTIt5EBGNVLHAHUjMBz37I+hbxFZN3o3HlvX6knPb2ujRMCU2CVqBKBvZ/98lNo/vuWsCx7WxeP5ml3z4lqHhXy8awaVDlpdzWjogMLZJmUJKLAIDI9FdTInnGhO4+fbdMR0pPdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774891109; c=relaxed/simple;
	bh=cdUZzuqsp9ReSZpV2KaDcIeCuPSSJHG+aQB6RG4udDA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f0jH8lUlLxYSAe6BkjxAZH58lrMbKd1SioLFpBHOIR/SIqaY7KELazCJiZ2z+1NYqgy+4pTck9AFpJ2nVNmJkz7k0o2HtcOE/ZdjbRPuMNYLt52rTarMmKgNTDDsAbvt+Ta6jxP//lVHWQzz1KJ4bxhmKYRuordQ3NjAnp5fo9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNz/DmsB; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNz/DmsB"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6501d242e3fso2171608d50.0
        for <linux-cxl@vger.kernel.org>; Mon, 30 Mar 2026 10:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774891107; x=1775495907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5WYAmZnCUHifIrZd5FYL4WM8RKjkmJnsMatxYMxfE54=;
        b=UNz/DmsBoOMOftLb7FZw6G6dc+1bM7nntmec8jH9u735hGT8VmuDywH5SZgfzXexQl
         jEo6AVICoYxKqIsBH9BFoEYnYfROYHj7PCk4F+3Gfh8a9Y1XdQXvjfQxewvbtlGSmmGT
         SHVbM1nKOc1ZxRnUcP5/Mysw0ArdHPzxeZCtbLnIa33vuNnZi48YCrSqN239wjrA3F+c
         VxyfIwkLW3RtSX5FqJBbF4A5DDyWAcvBloeh6M2oq1TMRBY/LuBCG3dFAHquGa9Rx6A1
         vvHGygQzjuP2X/UE5+4gXFDy+RqGHZYWhgHUlbksiLSpViUkGMhlyLLazSap6NJhCj9A
         KUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774891107; x=1775495907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5WYAmZnCUHifIrZd5FYL4WM8RKjkmJnsMatxYMxfE54=;
        b=kSKP617eseu2JksP5IqugXPZp0M3pQhknZZL4JYBfoj3YkF0PgdGPcFtwBBdSUx/hH
         SJeZWLPbjk0Wvizjx2D9yj6pgFWv7T66lGtB/llJhDxBL3ed5NbYGNg0N6sK0rscWXw0
         oJt6yRPqsU92LlQ4c7fUrOKRVRTSQqs5YQJUaE/yyfeVrnl37umEnaDdsGLvtjBszcA2
         ib0pgGDwxKellmtUW1iYvhpgRMBo9IX+COzKGDRnehW6i2renoS2hcHhfCKCsXCOuJNO
         zF5U4j3EIqGCVo3W36+5SRHiOMJX9XN0iGwunQSutt2vO/40TTXi05HL/42wTK5EBbxW
         Z5TQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKFKcCYao/r8P9Gm1lZdM4CFcThTvlEC1gMBpm7ZGFM3Elky8FHQ1dK4v1x9DNE4xnmGGBX3NeyWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXELDEbj0zZ4lVjV9jG/scbeB7LNyMaO/iYQzdh5DeoOixTpfV
	FuKxhe1Xcb7SNSDsUECxnq4h3udupEgTtvjd3ysJZp4cKt4PWxc9D9+/
X-Gm-Gg: ATEYQzzQAmdvDe3sCPmMhQFdtSGgqbHbd58aWm+/9tK1AB2Qkgn8LoKvP4Pa1BrXc88
	/UZc8sjRhmSX/tCLBq10G/oxY7xY1i3RcfPopHs8TXLtItyiOR0/qXhnCoPzyz1mFTMIBtHaejg
	bENnVYuc0fuFYKJwIZ4qSd4ffSYyB2GeEiQfLNM8DBaBhYJYUQhb97IR09bqUFrGuVjauHj1hBx
	R4gaZp9YHyUfcnYyjPapR79TAWo5E8Jdu72o5QOviB1FBICzHc1s+F0B3XiU7ohvNKB6YVW5oYT
	56EapNqsEtQCNYBxQF8si1Y256ehq7j1BOHKQPGr1UwzpIVyRVhLiPCYMAwcuu64c7TVfygOsCN
	sPBr58P/c2qFJrSv6THHLLx+aSaTp6Sudq3hx9TQCPHezmSmelPtMU4r+WJm9N8bqov2m7Up7f/
	Zm0GlXRys8kOFG1BLLK/WecX9JXv9hwRfvFt9VEWnYXQ==
X-Received: by 2002:a05:690c:6d84:b0:7a0:17f4:e754 with SMTP id 00721157ae682-7a017f4eaf1mr21444297b3.17.1774891106656;
        Mon, 30 Mar 2026 10:18:26 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79cb4521761sm38442557b3.0.2026.03.30.10.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 10:18:25 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Mon, 30 Mar 2026 10:18:22 -0700
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: Alireza Sanaee <alireza.sanaee@huawei.com>, qemu-devel@nongnu.org,
	armbru@redhat.com, berrange@redhat.com, eblake@redhat.com,
	jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
	linuxarm@huawei.com, lizhijian@fujitsu.com, mst@redhat.com,
	pbonzini@redhat.com, gourry@gourry.net, nifan.cxl@gmail.com,
	me@linux.beauty
Subject: Re: [PATCH 5/9] hw/cxl: Map lazy memory backend after host acceptance
Message-ID: <acqwXl37T1mquQvD@4470NRD-ASU.ssi.samsung.com>
References: <20260325184259.366-1-alireza.sanaee@huawei.com>
 <20260325184259.366-6-alireza.sanaee@huawei.com>
 <acozVjvVT1THZP_S@4470NRD-ASU.ssi.samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acozVjvVT1THZP_S@4470NRD-ASU.ssi.samsung.com>

On Mon, Mar 30, 2026 at 01:24:54AM -0700, Anisa Su wrote:
> On Wed, Mar 25, 2026 at 06:42:53PM +0000, Alireza Sanaee wrote:
> > In the dc-regions-total-size flow, a requested extent is not backed when it
> > is queued. It becomes usable only after the host accepts it with Add
> > Dynamic Capacity Response.
> > 
> > Use that response path to look up the first pending group's metadata for
> > each accepted extent, enable the selected host backend, and move the
> > backend and fixed-window references onto the committed extent list. The
> > accepted range is then marked backed just like the non-lazy path.
> > 
> > This wires host acceptance to the lazy backend lifecycle and leaves the
> > fixed-window direct aliasing to the following patch.
> > 
> > Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> > ---
> >  hw/cxl/cxl-mailbox-utils.c | 76 ++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 73 insertions(+), 3 deletions(-)
> > 
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index c5427adb3a..cc7be6e68c 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> [snip]
> >  static CXLRetCode cxl_dcd_add_dyn_cap_rsp_dry_run(CXLType3Dev *ct3d,
> >          const CXLUpdateDCExtentListInPl *in)
> >  {
> > @@ -3718,8 +3740,12 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
> >      CXLUpdateDCExtentListInPl *in = (void *)payload_in;
> >      CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> >      CXLDCExtentList *extent_list = &ct3d->dc.extents;
> > +    struct CXLFixedWindow *fw;
> > +    HostMemoryBackend *hmb_dc;
> > +    uint8_t tag[0x10];
> >      uint32_t i, num;
> >      uint64_t dpa, len;
> > +    int rid;
> >      CXLRetCode ret;
> >  
> >      if (len_in < sizeof(*in)) {
> > @@ -3756,10 +3782,54 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
> >      for (i = 0; i < in->num_entries_updated; i++) {
> >          dpa = in->updated_entries[i].start_dpa;
> >          len = in->updated_entries[i].len;
> > +        if (ct3d->dc.total_capacity_cmd) {
>                memcpy(tag, in->updated_entries[i], 0x10);
^sorry that was totally wrong lol! ignore that. but I did encounter a null tag
on host side when I sent the qmp tag-based rls cmd that resolved when I changed
it to prescriptive, so let me see what happened there
> > +            bool found;
> > +            MemoryRegion *mr;
> > +
> > +            found = cxl_extent_find_extent_detail(&ct3d->dc.extents_pending,
> > +                                                  dpa, len, tag,
> > +                                                  &hmb_dc, &fw, &rid);
> > +
> Btw, I'm using this patchset to test my current DCD RFC :) The main thing is I
> want to test having multiple extents in the same add request for the new
> requirements for tags on the host side. Since we can only add/remove tagged
> capacity at once (no incremental add/partial release), would it be possible to
> support that? Sorry I didn't have a look sooner
> 
> Thanks,
> Anisa
>  -- 
> > 2.50.1 (Apple Git-155)
> > 
