Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB38253958
	for <linux-cxl@vger.kernel.org>; Tue, 23 Sep 2025 09:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758619278; cv=none; b=sQFaoxcwEye5k+D4eLEDtCZb+nHe9kx4HMjsktw+T5uFDW/4sRr19Xy6eyiGaU8Zb75zvQuzFqtei+n1gCv5LNb8Lpz0D/mJUZmwxhYF3JC1JSOyfxzOHoQIJqOIpiOwcTwPzjBsr80fmvls8t5HdPjnsBFiozLOahI27RdIevA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758619278; c=relaxed/simple;
	bh=Cswo0LzDGBX49wI8j9kkVMGd7/Ano3IZZWfL4sip6E0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pLGURh88MSUgiLo5PRvVMN9RhLovohTMrzutK0U8uysJG0Meun4A0iGkrHmTNFrlwz9oz+OQek3WUFcgveiewG7uRFTavY3irSqMvUv0i6FuHqMEryBI8gcUk5FPREUHaCFRHHsdIMZWOOcr5E/3OwlV58GUC5Hf4D2N0w7Qs6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4u4AjKV; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4u4AjKV"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-26c209802c0so37264725ad.0
        for <linux-cxl@vger.kernel.org>; Tue, 23 Sep 2025 02:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758619276; x=1759224076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cswo0LzDGBX49wI8j9kkVMGd7/Ano3IZZWfL4sip6E0=;
        b=h4u4AjKVfmAEskwkOvwzqAgL88xwomHfGrvqa/5xhZTFEvKPRDxQ3mzuuNdgvUhCoK
         kf8eytRgKJqhaVcHEnd14tfDLk4r7F0OulEsicASVZuyYg0kGQVOdiS3RVqTmXs+RKfF
         5CMt5HxvdXkogUdqNdiB6nrFAVo7BZlFfk5fDdN7/YUVJGhWfK2vX2Czbky8A8EHk9Wz
         xmheSDvK9GN7pax/RoyTCabh7iBQUZAZHIhVaSIRi7HFJOdLpxbjv/FrtG/4C3KHWm3T
         6nxbMtXQ462veq5po0xK5zqGjkv5OfgiVKrhGSWLHCy56WGWB2HWeV5rrvxhxsKaxH7a
         vkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758619276; x=1759224076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cswo0LzDGBX49wI8j9kkVMGd7/Ano3IZZWfL4sip6E0=;
        b=W9OvKPRzm21K+DQ6zsgyXaV6q+6rfU3ahbFDFOKVM7orPW7GrPSQfKhgxnMhxJme1x
         qlUVrsIMIKypZqmbS3lIi8yh1AVT6RfgfTk9pY5N7YMD9pBAlMRJVbmR5CqIB5dnkVPD
         1ZHX8/wbWGsEk1X4+/uFan3cZ5uGAgiooyE/+Z7CHryxPrrwu8Llob0/rnydfT1N3Nm2
         N3ajS4LOlErZA04WSF2CSAO4VckJSwC4BLZhcPRwKvRF6HgAEgEG3OqOomZ251fMZRUp
         OLSNgXXaL4Avh4JOglTSyMXGiI0ueBnhjs25I+SEugrdzYY0MVTIq020Wvsjt+m8lNGb
         KGwg==
X-Forwarded-Encrypted: i=1; AJvYcCXdTJS52YnqoBjH/6/F9vxm41tJ63+aNKNAL2xucrXevaALESBP3gMb5wXXAigEB9lZkt88+fEcVYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcsU9Y5IQW24Zn8GhoZv434MdjVnvUCFei6g3pOR38SGl1QMuv
	K9hw4i0UiW9FaaA+yyk/DwFRladVpEsf4Q4rI9Vnjmyw/Ohpl9RNOupeLIceqZrJ6POWYpnnS/i
	CwXPiD7mmjWkMAD9nr6EW+yB8diuAWik=
X-Gm-Gg: ASbGnctuahSbqZvXw11kLiqF+Fgbun7FotDqJNwcOtSb6v+QSjM2FCK8CfMQDg0GfgT
	nISQSIWMUPPG8nmytB2tRaOug4t1BzqQUE44LZA1JeYme2X8EeDgx3SvpD1rno6oJvs8UmBlyKH
	3s31ZE6Aq5VAUAX7ZA3ywMn0QDWcb8o2K4CX2eSc3ZOfqa6md4ifWhWvVXOrIFaJdiZO650pql6
	acREoQ=
X-Google-Smtp-Source: AGHT+IEXMKhCjwTKhodebRPoXK/OAjJWAlGGH8OjPPnekcnhylOt4yiZehwUT2NqIW2Pj2CyhcJ/iwqTogEC2ndcvmA=
X-Received: by 2002:a17:902:e790:b0:269:a4c5:f442 with SMTP id
 d9443c01a7336-27cc712289emr25047665ad.47.1758619276576; Tue, 23 Sep 2025
 02:21:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827013539.903682-1-terry.bowman@amd.com> <aNIUAy6VbNdSzplJ@gourry-fedora-PF4VCD3F>
In-Reply-To: <aNIUAy6VbNdSzplJ@gourry-fedora-PF4VCD3F>
From: Srinivasulu Thanneeru <dev.srinivasulu@gmail.com>
Date: Tue, 23 Sep 2025 14:51:04 +0530
X-Gm-Features: AS18NWBwICuC4DXdolnXhBDgNb4F3syXj6-2puxjUsRmcPuIhwxe03vFc-A6n2I
Message-ID: <CAMtOeKLe-HtjpNze4WPj-knDDZTw3GRq6qMwpig6ygKH+Mq7AQ@mail.gmail.com>
Subject: Re: [PATCH v11 00/23] Enable CXL PCIe Port Protocol Error handling
 and logging
To: Gregory Price <gourry@gourry.net>
Cc: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net, jonathan.cameron@huawei.com, 
	dave.jiang@intel.com, alison.schofield@intel.com, dan.j.williams@intel.com, 
	bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com, 
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com, 
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com, 
	lukas@wunner.de, Benjamin.Cheatham@amd.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org, 
	alucerop@amd.com, ira.weiny@intel.com, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I had tested these series, Thank you Terry.

Tested-by: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>

On Tue, Sep 23, 2025 at 8:59=E2=80=AFAM Gregory Price <gourry@gourry.net> w=
rote:
>
> On Tue, Aug 26, 2025 at 08:35:15PM -0500, Terry Bowman wrote:
> > This patchset adds CXL Protocol Error handling for CXL Ports and update=
s CXL
> > Endpoints (EP) handling. Previous versions of this series can be found =
here:
> > https://lore.kernel.org/linux-cxl/20250626224252.1415009-1-terry.bowman=
@amd.com/
> >
>
> I know there's still some in-flight work, but for the series so far:
>
> Tested-by: Gregory Price <gourry@gourry.net>
>
> Please ping me if major logical rework gets done and i'll roll through it=
 again.
>
