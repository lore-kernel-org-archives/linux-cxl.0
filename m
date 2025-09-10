Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B6D254B1B
	for <linux-cxl@vger.kernel.org>; Wed, 10 Sep 2025 15:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757516874; cv=none; b=DvVJCphc3A61zTv87/vHe1JH4CIc73R+Z9zEBSRvYHJERYDT1FNf5qr9vKJ3K2dUsECTzb7ntTgJk+8ne3DV6aEZDX/b3v6Y86FDorNkx/PMkLpZ24a4wc9ySdtFNmg5jVpl8FzLyR7IiTAhGg1OuJPakokkndbm1xGCkitsHkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757516874; c=relaxed/simple;
	bh=y8m0jBS7QF7mSBtjPTJejL0GU8BqumBmxws5w8K4d4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EyEkQePbRE3iIXghVzK1qcDlO8z3sLIUZm0FNA9zupnLMw1y1G4H7kNhnE3L4I7QAoXAo52oImc0l2ro4iGTlPiv0ywGnTseQRnMJ+Xaau6f79Q4H22Phfx5Mte+LLdFdwh93SK67YXlD+DWyZTCDtoYuTItm2Ooa8t0NI1OJRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ipFymVzJ; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ipFymVzJ"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-721504645aaso54629906d6.2
        for <linux-cxl@vger.kernel.org>; Wed, 10 Sep 2025 08:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1757516871; x=1758121671; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TNdY3PgAZdaOe7FmnSpRTxifjOSbXP7fn6IEcFySgc0=;
        b=ipFymVzJsbb4kNskatPk1haPjllc0CtQTO6Q2vE1M0fomeDiY3jPgSYK5JnrgmxOVH
         bpn+imRs4dO1+yopf2Zt43nXDvarl017ns0DF8hUxQWXp1h1HTQermFcpbgMz1gPO1Vh
         Hh9q+9hRJyMC3J+uMOsaZk1eHiDnfrFZFf22pvLBLUZKlfJUKKM8VI89MUS3pcNV3I4P
         Yjx/sY7thJyi/a5H7YwO/jT39O70ik/PG+BKmq4ZxmPc2XqAucAsOAbRO/IdoDYAbvYI
         0ee6Z19dh8rXGDysh3ALPC2ZeZ4egBQzCvl29CJIUub8tE5TA4qVIytygULUfyr+XtrD
         0Efg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757516871; x=1758121671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNdY3PgAZdaOe7FmnSpRTxifjOSbXP7fn6IEcFySgc0=;
        b=RMG5ASP4nsdmfFTYiPrU7IHR/qdnExYmK8/akyeOTQalvU4mW9QlaatFhiSY4yhNuX
         TnHdo3n27hcul0nDIxNtQrc/U8gn7iZFtzsAp3A1aUL8yhI3wKmzSUF5WmADJLacdnoi
         Dd2K+0Ny4foviwIlYN0MyQQRapZ5NhjJ5WurSrX3rw7DNwWnatTtx5i9F70wjdHuxmV5
         Zcuw6ma114PWI/avWG9eAMZUkH5E0m8f5oOfSBiP6yK99+n5B1fXj4rnrNpaigtfM/Sa
         pTv3QltHa0+7EKncrj6NXo7DSFqCYXuEyyhyI2DLBjaQEC26Lz+wQx5GQp3UOJcIjqQM
         2RCA==
X-Forwarded-Encrypted: i=1; AJvYcCXuRui66MIibW6XHte8hw1z4wQ7KG9R0iBqwtwgiveCegzKl18pVSJPRgbMiitNUeLO5ef4WuamUjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcTTnvdJevmbLs4dtp58SCqKqqgR/oz9eIzNLgKXVI3QCdpCRC
	rZ8bcrEAu/YXvsZeClqSQzfNh/gFrD3c8iu1mqESw4sH7qOwwDTRZbkz/b0nMKgdueU=
X-Gm-Gg: ASbGncukF6dEGqKE/E2aMFNxKHLg5tq5aYGvuV33EJBQx8/hpprA/G5G7yjHTt19Ujj
	I7pq/rDqX2cyXPPEx7obBeXVL8w2fM9lbFIL/dGEAD+2YbTLq/XPfOvMguLnMY4pmgPt0TVWTac
	rYivflgx39iL/Q49IOXmlYm5aOyRp96SZUm/a3R9t8Tcjz/U7US6h8rMRBDjoGzzeioMk/sLx2W
	nU2tn0ZnO5tZRWyt97+r8wjig7slf9oGuBhvwSNtllaau87YEL7WQjKXnVTF4vSmZT03ZcqDEMz
	YXt+0jJvBZ3GT656XgtG9OkWjHA1+nyZ3PodlVoFRuG53364o5SPj1Hc11iqi7eCmLW2A680Ok+
	W3FyiIsy1jF4tNhswuF4=
X-Google-Smtp-Source: AGHT+IH+BJW22LupObBGk6NPwobuFYb41PxuJvvB4HPRo4i7+jxyExborwUK24gXOQ4lS4LmrCtzlw==
X-Received: by 2002:a05:6214:2386:b0:71b:6414:fd06 with SMTP id 6a1803df08f44-739256bd5bdmr177377526d6.27.1757516852901;
        Wed, 10 Sep 2025 08:07:32 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c091:500::3:1704])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-75856b44ac5sm23806886d6.2.2025.09.10.08.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 08:07:31 -0700 (PDT)
Date: Wed, 10 Sep 2025 11:07:28 -0400
From: Gregory Price <gourry@gourry.net>
To: Terry Bowman <terry.bowman@amd.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	lukas@wunner.de, Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v11 23/23] CXL/PCI: Disable CXL protocol error interrupts
 during CXL Port cleanup
Message-ID: <aMGUMACDTT5a2-XA@gourry-fedora-PF4VCD3F>
References: <20250827013539.903682-1-terry.bowman@amd.com>
 <20250827013539.903682-24-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827013539.903682-24-terry.bowman@amd.com>

Hi Terry,

On Tue, Aug 26, 2025 at 08:35:38PM -0500, Terry Bowman wrote:
> Introduce cxl_mask_proto_interrupts() to call pci_aer_mask_internal_errors().
> Add calls to cxl_mask_proto_interrupts() within CXL Port teardown for CXL
> Root Ports, CXL Downstream Switch Ports, CXL Upstream Switch Ports, and CXL
> Endpoints. Follow the same "bottom-up" approach used during CXL Port
> teardown.
> 
...
> @@ -1471,6 +1475,8 @@ static void cxl_detach_ep(void *data)
>  {
>  	struct cxl_memdev *cxlmd = data;
>  
> +	cxl_mask_proto_interrupts(cxlmd->cxlds->dev);
> +
>  	for (int i = cxlmd->depth - 1; i >= 1; i--) {
>  		struct cxl_port *port, *parent_port;
>  		struct detach_ctx ctx = {

While testing v10 of this patch set, we found ourselves with a deadlock
on boot with the following stack in the hung task:

[  252.784440]  <TASK>
[  252.789090]  schedule+0x5d6/0x1670
[  252.796629]  ? schedule_preempt_disabled+0xa/0x10
[  252.807061]  schedule_preempt_disabled+0xa/0x10
[  252.817108]  __mutex_lock+0x245/0x7b0
[  252.825229]  cxl_mask_proto_interrupts+0x23/0x50
[  252.835470]  cxl_detach_ep+0x25/0x2e0

This occurs on a system which fails to probe ports fully due to the
duplicate id error resolved by the Delayed HB patch set.  

But it's concerning that there's a deadlock condition without that
patch set. Can you help try to eyeball this?  I'm trying to get more
debug info, but testing system availability is limited.

~Gregory

