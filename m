Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25AE239581
	for <linux-cxl@vger.kernel.org>; Thu, 18 Sep 2025 03:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758165074; cv=none; b=TmON7EqCnthyaM0NSzcQ3YZ/bdd0SX+A+7TfcPMmFmtnrOpJWyeap8LC1woH4w7gAT4ve35OujQtiPI4BwwVinuCotNE/3FATaqAU805hWzF9h6GwWE01U3yLYyX027FNnaa15woYoAqb+PBVo0+MStsXjDdamzG0G+ApNaikkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758165074; c=relaxed/simple;
	bh=g6XjMivryjsQvDbKREuLJC67xZnaV6+z17E6u3VcMf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bG8UsLv3FOlsfdEOIYwThrNYryb7zpUK2ZvDm03zLMFVGficGd9TqyDLSwPXR5bgkDh47IzI8WafVZqIWCIkZ2gXR7WAPJCzC070uETbRWq8Y+AFcaeQUOjGlB9Bdq83LlUYihRd4odzhE5Ah2+K9nDMt2oESUgno7J2k8Sy7+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwCXnrZEeMtoD1vgCA--.10S2;
	Thu, 18 Sep 2025 11:11:00 +0800 (CST)
Received: from localhost (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwAXeuc_eMtoJjUUAA--.17208S2;
	Thu, 18 Sep 2025 11:10:56 +0800 (CST)
Date: Thu, 18 Sep 2025 11:10:38 +0800
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: rad@semihalf.com, peter.maydell@linaro.org,
	leif.lindholm@oss.qualcomm.com, chenbaozi@phytium.com.cn,
	qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	qemu-arm@nongnu.org, ligen@phytium.com.cn
Subject: Re: [RFC QEMU PATCH v7] hw/arm/sbsa-ref: Support CXL Host Bridge &
 CFMW
Message-ID: <aMt4LqSympNcVqnb@phytium.com.cn>
References: <20250807111037.241118-1-wangyuquan1236@phytium.com.cn>
 <20250917173914.0000331e@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917173914.0000331e@huawei.com>
X-CM-TRANSID:AQAAfwAXeuc_eMtoJjUUAA--.17208S2
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAQAWjJu34I-gA1s3
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoW7Xr1ktF1fJF4rtw1kGw1ftFb_yoWkWrb_ZF
	s2yr9avw4vkF9FgFsxt3ZIvrWftryDur47XwnrAas8JF9xtas5uF4DKFna9345Gr42qr42
	kr1YvrW3tanrZjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
	Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
	UUUU=

On Wed, Sep 17, 2025 at 05:39:14PM +0100, Jonathan Cameron wrote:
> On Thu, 7 Aug 2025 19:10:37 +0800
> wangyuquan <wangyuquan1236@phytium.com.cn> wrote:
> 
> > From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> > 
> > This creates a specific CXL host bridge (0001:00) with four cxl
> > root ports on sbsa-ref. And the memory layout provides separate
> > space windows for the cxl host bridge in the sbsa-ref memmap:
> > 
> > - 64K  CXL Host Bridge Component Registers (CHBCR)
> > - 64K  CXL_PIO
> > - 128M CXL_MMIO
> > - 256M CXL_ECAM
> > - 4G   CXL_MMIO_HIGH
> > 
> > To provide CFMWs on sbsa-ref, this extends 1TB space from the
> > hole above RAM Memory [SBSA_MEM] for CXL Fixed Memory Window:
> > 
> > - 1T   CXL_FIXED_WINDOW
> > 
> > Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> This looks pretty standard to me so FWIW as someone who hasn't used
> the SBSA model.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
>

Hi, Leif and SBSA folks

We hope to hear from everyone regarding other suggestions for using the
CXL on the sbsa-ref, as well as any areas where this patch might have
been overlooked.

Yuquan

