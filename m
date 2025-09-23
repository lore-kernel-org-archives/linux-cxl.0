Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB0C25484D
	for <linux-cxl@vger.kernel.org>; Tue, 23 Sep 2025 03:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758598152; cv=none; b=uwt+b3zeEqCNuDrvc9YEUWSn24AvGbpXL/fNLZ1jbDyefFQJQKCNJB3qMSxrmQrKj5sUsEqSsRP+/+VCdScvkv824zPmdgPPoAykZalESC1KV1S8SHa5XUHaIwJYk+CvqU4DqOevRfsc+L70aGHYelpek6gwpuUPvd4rrkmHbNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758598152; c=relaxed/simple;
	bh=EXwzx+jqaKv7lifaMmXXEYRnm1eiubi1vxbrL8+Liog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9qDH5r19hMTDVttO/Oauo3bYBDiXyRoyl22q4uXH9nP5TYgX3TwjORvfWl5XuNRY3eNXH200XZXiyH12fCJwmcmbrJlnxdNoZQgIb4qwPNNk6zMs8yjObqV5MYMGALwV8CmkupvvG1zo057pAC+D+UK852b/wjwCAgualzJAsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=OHg+a34F; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="OHg+a34F"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-88c347db574so165670439f.0
        for <linux-cxl@vger.kernel.org>; Mon, 22 Sep 2025 20:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1758598150; x=1759202950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EXwzx+jqaKv7lifaMmXXEYRnm1eiubi1vxbrL8+Liog=;
        b=OHg+a34F7gBNu2ln4g7T5ELLoqz3SFDECE3JAY73bh9zSNypV1NwXD9LKPIrfPvp0A
         US3QilXd+5TAy/oxA4KPelP5X3ofIk1IhtMRdhCx0FwyaiJrIuEjt4lpMqoyUZuXCekz
         Y8or8qUXxgro2LcFTqSWBZkgc1/kjqWlQTe7Z/qytpKM9sO7V2fZA2SzI2ypKh6bEPbU
         jJPoBMeQwzMmEaIbnbq8vPUAVEzl1Ufv8Orm/rnIGkTEe5Zx8igsGABnvY1PITE8remi
         n1DKSa1gi9QHXViMb9QRpMUXli8bc8u3tJZt5Ua8Ja0Obh1/wMyUc/eS5vble7p2zSlx
         Yn6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758598150; x=1759202950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXwzx+jqaKv7lifaMmXXEYRnm1eiubi1vxbrL8+Liog=;
        b=dukEzbhbO0BG8yM0NUqCSddRGa53vFBJ55/MFnWImU1I6ZAabsd+mVx1PhKGe8TBn3
         oBgSNwLVNr3m741a1/gI3UJifv6PTNkP09p8AnrR8T0mo1m2tQn5i9KEIDnrzDsvejTi
         CynL8LdHNsU9mGRXy4L4axhmxENTUhEx1D3xaSBgeTnNoW26D7k2xPzOjnaewpvJp35o
         aI+5U5o3aqEEWZEhiU2SmTYj4prf2UUojBVDSjE1BeGz2jXWaVmfaoUrgw2MdXGWMJNj
         I45uiz8cfUbKClos0sdJNJFWd/5QOAqsiqtL/9Zjmt3debkQAFek+9kZ9vYLHxZbKoYK
         Briw==
X-Forwarded-Encrypted: i=1; AJvYcCXL6sReQQJjmuT2Qk4B1YSZ4lFmmEMnbL7xlp1Fn1JsOoMGYAozHaw+C+/tNAYNKv96dDES9gxTckI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzrPP5VPF3uB6fLlvY/MmplMZnoYfB8HRu7Q8Re10Mw4v9KvF/
	UGT27JWh128aEcV4br87B0ushk+wmZGK8+HSwxMiTII/XhgsQ0IZ5nqajAaFDJ4+40M=
X-Gm-Gg: ASbGncvdjwjOz9hBOcq9IilnKwcVQV6EIr5IC+RJo10+nPcT8tFflH66fKkQRkS15Sj
	+HHIpYRFPpuhnW6jDROnehc5R0FIQ67371RdXR6Yk6NRzLsvtum1L17QziYxNs/uQ+EKNW2VO6P
	WvXwWIW4VILAPQXE/102tGxmWNuwPCuoGuPuktnWGnBR+CY/aaQ3lGiAlxV6kCL9AEgPd5LozcF
	ThyfFMnx/7DKcA8hDNXnFXqaTD3ZqtlTw9Us49lJbqkBJOjheRfCq7uvx61BfMBJmMa49nghBCP
	y4mFYvoPRpzjlaXi7PvBS7DdY54UEqFhTG1z2LBiMYjmwrelWdVQlm47uXduKlf2WHwuA5p+/4Z
	0BIwAUPWJcm7VZUHKQ0/eCmcq3uPEJSQ9RiLCBwze9h+0HWvv8b1dmVRXpF1EWgwQjrlbER6C/2
	U=
X-Google-Smtp-Source: AGHT+IEFnoJ47e7b8X7FUCgUXJFp+M6HEk8QQku8r2B40eiA6Wxiefxrlh1a4+99394BsiieDEPFQw==
X-Received: by 2002:a05:6602:2cc6:b0:896:fcb5:4ba3 with SMTP id ca18e2360f4ac-8e1c4800940mr291928639f.4.1758598150200;
        Mon, 22 Sep 2025 20:29:10 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (50-32-2-77.vng01.dlls.pa.frontiernet.net. [50.32.2.77])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8a46b2f3cdasm503126939f.4.2025.09.22.20.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 20:29:09 -0700 (PDT)
Date: Mon, 22 Sep 2025 23:29:07 -0400
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
Subject: Re: [PATCH v11 00/23] Enable CXL PCIe Port Protocol Error handling
 and logging
Message-ID: <aNIUAy6VbNdSzplJ@gourry-fedora-PF4VCD3F>
References: <20250827013539.903682-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827013539.903682-1-terry.bowman@amd.com>

On Tue, Aug 26, 2025 at 08:35:15PM -0500, Terry Bowman wrote:
> This patchset adds CXL Protocol Error handling for CXL Ports and updates CXL
> Endpoints (EP) handling. Previous versions of this series can be found here:
> https://lore.kernel.org/linux-cxl/20250626224252.1415009-1-terry.bowman@amd.com/
>

I know there's still some in-flight work, but for the series so far:

Tested-by: Gregory Price <gourry@gourry.net>

Please ping me if major logical rework gets done and i'll roll through it again.
