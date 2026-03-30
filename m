Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13734315F
	for <linux-cxl@vger.kernel.org>; Mon, 30 Mar 2026 08:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774859098; cv=none; b=iyFq8M4AG4M7JK9e2NGBv2qFSRFmK5P78txxwfFWxHZQSFUHcgzVl7+f9Mp0WPmg8h4cs+soOI3qcpRZjLjm4T4g6srSEyZ9bkXaFdwy92RqJx/SRqFH3aXm1GqemPM1AEN4YQtUEG29a0mNhe2HS7/OqEchP8V44McYpcXNzNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774859098; c=relaxed/simple;
	bh=kvm8Cs7D/fkLiiNkxYVqeguE7ebRhZj5DhY+LblxUd0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hK03XC1N7Z6pnTtrkgo8hquRt/Wc/fNquglOfvBKEI9uLJScHZodVgFTj8h+5lXI4YhUL8QrkG8/Lo9oCtCI8Ip4jmGkTzDwsJt3svaGOBIGfDgmXGBilXlHk2J13BCnnIfEXaE5wgWmUFD1vnigvwpePlmQHuVvWZXPnm/cFrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dx8UId7R; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dx8UId7R"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12732e6a123so2588002c88.1
        for <linux-cxl@vger.kernel.org>; Mon, 30 Mar 2026 01:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774859097; x=1775463897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g5TduLyOB2E5auatV1YEbPKRJcZ4ZLa0E2+8Df6dxNQ=;
        b=Dx8UId7Rw/PI5nL8sRhlqgc49r+5h0rZdWKBdWfgbWuQhidXTsSWCewg6LLEhxNZUC
         Jx+u/sGspxvwbzTVtjfYWZOXw5RELMfMN0xpQgt4TSHZU/QJFHDJp4tAO/KrnsHK/S0I
         dsY4Uce9kuLl/BUOKJoOyi48FZXJ2L5VAkJF50fXly0gPVDZ9iQCbMWqekgxYfWNcVGe
         Q5uuBXrDI63M5tby3K+jdNsY4+KA1vfZPZgpufNT/R7jrfd6bnC3nDSt5ftaFI3AMFJt
         xDrbxT+O0/XxdfRNcXxkhjTCZuJxETQ5mpOcvtHKwfTJmjck+PEXD28Dr+6oXBtX6Aov
         IcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774859097; x=1775463897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g5TduLyOB2E5auatV1YEbPKRJcZ4ZLa0E2+8Df6dxNQ=;
        b=i1wJg22fkZHbrLslWSarECPZA9d0hUIrocIeiW1wDa3/9ZdUXE9fhZ/VtHXWQtc1wa
         44QIyinohQzox2B6YfEHdRWVrmk+RQZRKqAFQ8mIYRAcFJYRTQ89FVoF0xX/fdwr8lTu
         T0nbRwRFwwiy8z2YB8/f42aaPgW/zCcEETXDsZv3yj3QwbsTGWkOHHgdXpIhfyI4xL8h
         8gOWNaBLHQtuBjmnJwu94IMJ3kI4vzbVoAlFrCTR9FoT/0v2EAcwvXrkXKpSQVM0mQ+l
         MNGcqNXVmaD+V7BIiyFYzQLzGnH2G3C0UwzrlCb+JefuTA7MT2G8ZPWGzlsQVVSiJnDj
         jw+A==
X-Forwarded-Encrypted: i=1; AJvYcCVLfKVgVgspH0YTNqg3tbq+32hA0SE4g1tHJwnGbKIsX8NDYxTVEsPvijun2sKsqSW9eUbxBbhbKAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCXB99V0BL3bs4+csNOdr4RmpfHTll9pGWgtlh1sJ/bZdiRi6N
	9+9X+h7LPDAF51z7fmxaPQuFKSzAOjpotnCC3gMUnhJQjfvmJdjjU07C
X-Gm-Gg: ATEYQzwaDLDTYa7XFtXKIEiwQF5cGSKoHLI6ME80+EQbswKumCD+31j9ZgpA8lWXmTc
	7PqdAvv/SyJTDIJ3/3T25GwF6X5qbexpPLUQp74i62VqcrNHobXveT0iFDi9VCJjMs343vuIaB2
	95bNVNWI4GCHE5JRPjuTg8wYC3BNvBGyIBBXJ6/bPR1IEuLc5GUv3KEOvUNvM759th51sKkJ11X
	h5sB6zFYcZxa7HPXyQXzaQUNjnV+bwcX1j1gLAv/HLtOoQ8FUZoFhrKfpqCUcx7kyXfVbDnCY3T
	2hrQO3sbecFq5WMJPKObCYOg+WmR82AYH7/QnKUabMpUBmetJj2qbl3CT+WbPfCgSLI2TuFAXYZ
	wbcA9/ayIjqASed0BeEc6hugU3JK9S09i5EvAfEREseBL6woDx3VM1taKf2Tz9ZP1e8q0iw6Hek
	LMWHUqYlH48A8tn/oBC4Cn3m5sFE0IEsPODpAkHF2BKlM9LWKK/1ikYDtlRAz8kw16qGZnq7vMy
	M4hH1oE2vcg
X-Received: by 2002:a05:701b:221a:b0:12a:b3c4:c3b6 with SMTP id a92af1059eb24-12ab3c4c608mr3436080c88.21.1774859096593;
        Mon, 30 Mar 2026 01:24:56 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab97e7a57sm8777404c88.6.2026.03.30.01.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 01:24:56 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Mon, 30 Mar 2026 01:24:54 -0700
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berrange@redhat.com,
	eblake@redhat.com, jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org, linuxarm@huawei.com,
	lizhijian@fujitsu.com, mst@redhat.com, pbonzini@redhat.com,
	gourry@gourry.net, nifan.cxl@gmail.com, me@linux.beauty
Subject: Re: [PATCH 5/9] hw/cxl: Map lazy memory backend after host acceptance
Message-ID: <acozVjvVT1THZP_S@4470NRD-ASU.ssi.samsung.com>
References: <20260325184259.366-1-alireza.sanaee@huawei.com>
 <20260325184259.366-6-alireza.sanaee@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325184259.366-6-alireza.sanaee@huawei.com>

On Wed, Mar 25, 2026 at 06:42:53PM +0000, Alireza Sanaee wrote:
> In the dc-regions-total-size flow, a requested extent is not backed when it
> is queued. It becomes usable only after the host accepts it with Add
> Dynamic Capacity Response.
> 
> Use that response path to look up the first pending group's metadata for
> each accepted extent, enable the selected host backend, and move the
> backend and fixed-window references onto the committed extent list. The
> accepted range is then marked backed just like the non-lazy path.
> 
> This wires host acceptance to the lazy backend lifecycle and leaves the
> fixed-window direct aliasing to the following patch.
> 
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c | 76 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 73 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index c5427adb3a..cc7be6e68c 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
[snip]
>  static CXLRetCode cxl_dcd_add_dyn_cap_rsp_dry_run(CXLType3Dev *ct3d,
>          const CXLUpdateDCExtentListInPl *in)
>  {
> @@ -3718,8 +3740,12 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
>      CXLUpdateDCExtentListInPl *in = (void *)payload_in;
>      CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
>      CXLDCExtentList *extent_list = &ct3d->dc.extents;
> +    struct CXLFixedWindow *fw;
> +    HostMemoryBackend *hmb_dc;
> +    uint8_t tag[0x10];
>      uint32_t i, num;
>      uint64_t dpa, len;
> +    int rid;
>      CXLRetCode ret;
>  
>      if (len_in < sizeof(*in)) {
> @@ -3756,10 +3782,54 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
>      for (i = 0; i < in->num_entries_updated; i++) {
>          dpa = in->updated_entries[i].start_dpa;
>          len = in->updated_entries[i].len;
> +        if (ct3d->dc.total_capacity_cmd) {
               memcpy(tag, in->updated_entries[i], 0x10);
> +            bool found;
> +            MemoryRegion *mr;
> +
> +            found = cxl_extent_find_extent_detail(&ct3d->dc.extents_pending,
> +                                                  dpa, len, tag,
> +                                                  &hmb_dc, &fw, &rid);
> +
Btw, I'm using this patchset to test my current DCD RFC :) The main thing is I
want to test having multiple extents in the same add request for the new
requirements for tags on the host side. Since we can only add/remove tagged
capacity at once (no incremental add/partial release), would it be possible to
support that? Sorry I didn't have a look sooner

Thanks,
Anisa
 -- 
> 2.50.1 (Apple Git-155)
> 
