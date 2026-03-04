Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CD238F654
	for <linux-cxl@vger.kernel.org>; Wed,  4 Mar 2026 23:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772668606; cv=none; b=sn2qrKqCkwebyw1Q2Juw/EEYEegWrlUQMJ6fMnLjIOAUPSQyngkYoSR5lHmRRUhOBxXYn0yaoCM9HAeQ4yKz64YWQmLG3yGUVNnoDY6P86/y+o6b65niNKBMtbj+7l517XGlcXDJX/vWphSHViaQQXQrg6+eSuLpXvFv7fFkQ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772668606; c=relaxed/simple;
	bh=Giw3/067GrNgQbtrZLaDCpoqSBeafl6A+nGzlEidTog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vp0F9fIxe6LMWV0B5aob24JwOWMWz1LmjrUbCe9E31g8df02troW+WDVYfgHZs1c5ryP+zS8ND+UEBQjf1+vUHJ1zx5TXbJhX43t0DdXLeSS8W0LxPBC5mMw8sfgOe5PiYnarKFhAiurdDDDkLX0WY3S63j2X22it5Cg3pKqYg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=jeCVDXv7; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="jeCVDXv7"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-89a0ecbc713so27669356d6.1
        for <linux-cxl@vger.kernel.org>; Wed, 04 Mar 2026 15:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1772668604; x=1773273404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dpj9qG8Bv81Wer9VtkXzUxrZr6VBH25/Zpz3n0Y4DLM=;
        b=jeCVDXv7cPpnUxHKQ6+sRoDowiat6zA8+nuoSIf0rYiQA4kKGYp8nAoArLUIjJF/7o
         WeFgdEih2jW0Tl6vBBkM1DiA1HqFnlF3SS9tp7U6ZjH4rHuj84wZNSsNk1co5HJNFRZL
         zOHYgzJy13RQYjwy+gKanYSqHL8ltRZumjIvgOZas5wb7nT6megXQ+g7vbFK7GFbYy+Q
         XlkCfM3zyNwdmSbK5rBfWyDStdzU8Yez13UcNwksu0qWbMhSKhJe1zUpH5coW92hKXA6
         Bd4/Zl8/BhPHoycMS807BokSia8pM5wVaMVzZnex+MQinK9QgiZRlEnRqVlGvb2koqtN
         G3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772668604; x=1773273404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dpj9qG8Bv81Wer9VtkXzUxrZr6VBH25/Zpz3n0Y4DLM=;
        b=u9thfEj5NDzUyN9Mv3w4Ys11e3/eogr27XnHECHn8DZz9RZ6G91Q0jpaYPgHxY/+Yu
         lyxQSZEusiu7b1xsqXYl0iZWddNNb7i60ObSfihmIqGDbA2/G0AWdiAm7aB+CULONprC
         C6fmcwkTzbl4tl4ysh3Z6T+G6TJhQEFhJMvebbxFH2Z7XCihr9n9dtJiiF95f44oguOk
         FtJpnNqmFxg2MQplk5c81aoFx+LN/u0rPcgw4p3NkKpnINfv1ziacVIUf7p6ERGY/m/Z
         +dlDfliwoDcGZ/NkUtP5mw6EqhJpMsHObS+u4+KHh7X3Odt3duN+o26pWU0GlqWMp+fO
         9aWg==
X-Forwarded-Encrypted: i=1; AJvYcCVskD6ZjNIJTbL0JR2HjW7TIKW0p3ECnQ1dKN4rVr6N6GrmlvyOxZUCIXW4W/eXFJkxHy/oSluBTFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGW9RjOKg+5otiGmB3h3xWSYXbMW71JZuCe6q+7YUIvgbsIHob
	9jVNEnCHRTgBSKf8OHoP+mVqaWHKZbnPE31fDPlC32ehMgx+h6vIy8bqAnaXxocllsc=
X-Gm-Gg: ATEYQzzeWLUABOzzwoDv5A9Qfg20LmvNTVasQ6NEhn/GexuBuZFaaGF1RT3h7PtN4Ni
	RfBh21hsr2Ls4kMYqIy2W9LbD9Jo94qS7DTW5+evsQm5zrPmaEmyYFUUIG1jlmBhbIcVwPkJPbT
	JazmiZQSmj9ZF1FMUfJuyt+wRRKqdSSnFrEXJT4KNMk/WNCmbdy4BgBL00Itsecn8EZq9A6d9Qb
	vaU/ThV+yAHvg/QjecI2Y3M7XoPMblIgO91AofD30J//P/+o1/MXnf7Otf3bS096uo5I59LAtaf
	//aOpFYrrri1iTKC8FVbsz71ijlQii8yveWkM8U9HPC2hYgvNPlJ8lr6kNGpMJbQzxvt1nFRm+v
	LUcRDlENrXu3Y5UvSzgWvQq2FjhAR/lwEYaC92BcaTuDDGIP4nYghMtUE4yvascyxu3XxWpj6Yr
	jIYDsZPgzmwWIPrLv+AwSOBAquBvXFY7/+jhb0g5LrC+ts+Bxw2XxLMNMA+wsz6Y/ze9uhdxo/k
	+JfxHZeKg==
X-Received: by 2002:a05:6214:20a8:b0:899:e8b8:504c with SMTP id 6a1803df08f44-89a2490cb15mr6076996d6.30.1772668603583;
        Wed, 04 Mar 2026 15:56:43 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-507449630b6sm186648081cf.7.2026.03.04.15.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 15:56:42 -0800 (PST)
Date: Wed, 4 Mar 2026 18:56:40 -0500
From: Gregory Price <gourry@gourry.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Kai Huang <kai.huang@intel.com>, rafael@kernel.org, lenb@kernel.org,
	dan.j.williams@intel.com, akpm@linux-foundation.org,
	nunodasneves@linux.microsoft.com, xueshuai@linux.alibaba.com,
	thorsten.blum@linux.dev, wangyuquan1236@phytium.com.cn,
	linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: NUMA: Only parse CFMWS at boot when CXL_ACPI is on
Message-ID: <aajGuOC-G_dFYpwa@gourry-fedora-PF4VCD3F>
References: <20260304213342.5776-1-kai.huang@intel.com>
 <aaizNh-0LEvRQMCy@gourry-fedora-PF4VCD3F>
 <aai-K2tEdIp5B4XP@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aai-K2tEdIp5B4XP@aschofie-mobl2.lan>

On Wed, Mar 04, 2026 at 03:20:11PM -0800, Alison Schofield wrote:
> On Wed, Mar 04, 2026 at 05:33:26PM -0500, Gregory Price wrote:
> > On Thu, Mar 05, 2026 at 10:33:42AM +1300, Kai Huang wrote:
> > > Increasing the 'nr_node_ids' has side effects.  For instance, it is
> > > widely used by the kernel for "highest possible NUMA node" based memory
> > > allocations.  It also impacts userspace ABIs, e.g., some NUMA memory
> > > related system calls such as 'get_mempolicy' which requires 'maxnode'
> > > not being smaller than the 'nr_node_ids'.
> > > 
> 
> > 
> > Is this a Linux issue or a Firmware issue?
> 
> IIUC BIOS creates the CEDT based on the hardware it 'sees' as present.
> 
> This patch is describing the case (weird as it seems to me) where we
> then boot a system with ACPI and NUMA enabled but CXL_ACPI disabled.
> 
> So, I don't think we can blame BIOS.
> 
> > 
> > Is GNR exporting more CFMWS than it should?
> Not sure of any limits on flavors of CFMWS's a BIOS can offer.
> If BIOS can carve out a window, it can create a CFMWS.
> Not clear how that matters to the issue.
> 
> > 
> > Is your SRAT missing entries for CFMWS that are otherwise present?
> > 
> > Are the CFMWS empty? (is that even valid)
> 
> Why this line of questioning ;)  I see the problem as a bit simpler.
> We have other code that tells us if the CFMWS's are valid, etc, but
> the point here is, we are not going to use these CFMWS's so stop
> the parse as early as possible, like right here as Kai has done.
> 

Mostly i'm wondering if this issue should be dealt with in the acpi code
or if the issue is that we just don't want to figure out how to
lazy-create these things instead of always creating them at __init.

it does seem rational to build out support for CEDT entries if CXL_ACPI
is built out, but this also means you can't otherwise load modules that
would have made use of this information.

This basically says if specifically CXL_ACPI is built out, the NUMA
structure is forever lost - even though it's accurately described by
BIOS.  Maybe that's a rational decision, just kind of prodding a bit.

~Gregory
