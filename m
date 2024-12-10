Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45FC214213
	for <linux-cxl@vger.kernel.org>; Tue, 10 Dec 2024 19:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733858020; cv=none; b=RMKJejgldlCV+BfMQ16G7Qt0bLlV0NxItbRBkiLFWmaqFh11CdV6F2ww3e/LAdQ4moVP509C4Zwiw5kZeRrMYm75P07dzktLkE2u1vOmXLJe+QGkkZtpqDqbown0T7XvVDYRUHd8lNNE+uBrPVq3LNc+MYaQmG+ej+MzS8oKvqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733858020; c=relaxed/simple;
	bh=Xx1PmF+uun2Un4CjV3brCWjSrSS5Zirrbh19iv/C6XE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YaVeoFb+2H6Qc1nbL/vCbeREjMHRcbUYINF7aoMb0BWiPS4iSo5295jWxevJxrW9ok2MfHlF1/j4zgIMUTJaG9V+Zm5PsXKVo7yKYl8pU/FSdA0q4jRoNPcmxITHd4hUaStpy12yvCBfinu8CG+FYX7ox48Xlyk1b5gHizO+s50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=kqKs6STI; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="kqKs6STI"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6d87ceb58a0so47585126d6.0
        for <linux-cxl@vger.kernel.org>; Tue, 10 Dec 2024 11:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1733858016; x=1734462816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=97qOTYSoAyV6vd8Z2GN8GpBHNVjhg0i4wTdV+vq41wg=;
        b=kqKs6STIhUSl1acAV3eIb3LGcAkG8hfyry3moedRMeXkK9TaqpqUUfnG4KqOQv8Tgk
         D/w+B6/sXeJIIl4v44im6+BOjgaVdHx9eL5g3x9ciwP7z8VXmFN/iBlt2ejDQtzx6+zX
         dogylkGGKlwP/Xjn6FjW+bTIEkaCDsE7xu4Fcw+cyqdr39ImluXD6KOF5PvQZSDbc915
         r6qc3Xx6fptGKYTrHeHe6kEs0lcNC8fitLmnCxH6ykzxKCbkfNnph+PbGUUIowvVXfeF
         cCf6XLTbHTGjwgmxJ/nKCy2Fnrn7M5hrOM6lc9NVGl5PqYjFU7qP+wGGIWkoj4BHlaNy
         I7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733858016; x=1734462816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97qOTYSoAyV6vd8Z2GN8GpBHNVjhg0i4wTdV+vq41wg=;
        b=qpM8iRaCOuSwpL/iISeJWv52gs2sJp/Hi0D7b+/L+6cIrvz+9/LYApEUzI9BAQ1k7S
         y+83Wz/Hq3jE4vzgbse3TWPtEq/dgdYesUDaxKLcUUOpZd626qXCq9L07RzRRqIVdBTm
         v0Dhz0F3rBJP9kBpCNgyp5Imw1hK9+G5Hy4R2CdHA+DdcX2yFj8/7nvQietcpkaBXFpU
         1K/XnMNQGZa5wNBsIrANJaETxB299pFnWrh9fTGcbUUIZ2LhMpl+Lpi72zXsvmZIbpTD
         nSvzUp7ALAu9nGM5YJZGuwbedCCM7ZV2nH+SKxbJAXNdaPz7EUEkMAHZWzZDmxPmomLy
         o/CA==
X-Forwarded-Encrypted: i=1; AJvYcCXtXjmv7G/42eIsC7aq9TaLhLkIdkJLeISJLzg0fwr8TXIu0TCndMoqeHYyFMYTTi50rbGCXL606zg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSQp7Xw419cRdnSFqF1Mu2roYWzGAJrALlGgQr8p+3DbbQozsk
	APFZF4HnNz7/IYV91/nIKkMBO+aXzORasezVHSaVcz3pwYCxRmqNs22LFvQCUD6alZDCfHW2ksD
	L
X-Gm-Gg: ASbGncvnk7exwwMPknR/AE/Iw8mjjLwet4IBQLBZCFt+10xgBEnozoFeBwoUXMW2x2b
	Z3DdUrsEU/PUO0VtExzi1EliWASstCmIxwy34Ene9b6lr4dZjl9vcmREm3whzcghn/7pVeROzRh
	GRiQEL1Gqgo1TWe5nG6CXwQlgMEninK2cyfw2GHp2ks500DWgUAwFLQL/4Keo56EmnecydPi1Qo
	xLk+dutx09llQ6XkiSRxZPoWLJGh7qzxzpb93DgtKzlt9/E180LwhOsJfstBcF5P2GfcqbJhNui
	mEBszp9hNvW+LCbh50aC/OyCjSrbOZqUP2fodpE=
X-Google-Smtp-Source: AGHT+IHRrfRfIZnKItsDYPM0ONQeei8VT2blcHwcAuFVhWCu+WYuv/fhCeiX5KBqdP0FaQ+PR8gyhg==
X-Received: by 2002:a05:6214:f09:b0:6d8:9124:878e with SMTP id 6a1803df08f44-6d9348c984cmr2901076d6.4.1733858015734;
        Tue, 10 Dec 2024 11:13:35 -0800 (PST)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8eb619443sm50877846d6.26.2024.12.10.11.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 11:13:35 -0800 (PST)
Date: Tue, 10 Dec 2024 14:13:29 -0500
From: Gregory Price <gourry@gourry.net>
To: Hongjian Fan <hongjian.fan@seagate.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"fan.ni@samsung.com" <fan.ni@samsung.com>
Subject: Re: [PATCH] hw/mem: support zero memory size CXL device
Message-ID: <Z1iS2SeYSOQqdLVU@PC2K9PVX.TheFacebook.com>
References: <20241202230310.1531219-1-hongjian.fan@seagate.com>
 <20241203172328.00001a00@huawei.com>
 <CH0PR20MB42505D4F82D534A85EEA4C2A90362@CH0PR20MB4250.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH0PR20MB42505D4F82D534A85EEA4C2A90362@CH0PR20MB4250.namprd20.prod.outlook.com>

On Tue, Dec 03, 2024 at 09:15:51PM +0000, Hongjian Fan wrote:
> Hi Jonathan,
> 
> I'm trying to emulate our memory appliance which is similar to a MH-SLD. The memory device is connected to the host server while the size of the memory could be changed by the out-of-band fabric manager. If there is no memory assigned to the host, the CXL device will be booted as zero memory size.

This should not be how this is done.

The ACPI tables should report the maximum possible size, and the DCD
infrastructure should enable physical regions that have been added to the host.

Changing ACPI tables to report 0 memory size will basically result
in the host memory map not reserving physical memory regions for that
device.

See this emulation example of an MHSLD - which can be used for DCD.

https://lore.kernel.org/linux-cxl/20241018161252.8896-1-gourry@gourry.net/

> Recently we got some interest on trying our fabric manager software without having the real hardware. Supporting zero memory size in QEMU will be needed in this scenario.
> Some detail about our memory appliance could be found from our OCP presentation: https://drive.google.com/file/d/1i8kBsBfRGjNqnTQqJ9upC-Xm9o56Y2Y5/view?usp=drive_link
> 
> Thanks,
> Hongjian Fan
> 
> 
> Seagate Internal
