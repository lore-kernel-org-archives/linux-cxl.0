Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F217C1A254C
	for <linux-cxl@vger.kernel.org>; Fri,  7 Feb 2025 21:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738964173; cv=none; b=oI8gH5Cs+t3GPXVJjv/9NbhpX+SRXnNI9RgI5S8sdGSKbuHNjAtUOTrNA5Cs5su1GVY4df2XjWSOB4hywvCQ4XGOcHLFFrlQAUnO1WQYhpxNAxT8xaUjUy3EIjFsTZ6DoJAEDD94myUBzj3E54wdY44NPRK8E6IptBqAo3Q72wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738964173; c=relaxed/simple;
	bh=em4d7q4/4/lk2sf/I7ehijLHymxDwUlgAoCxq6MRmxQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iUYZfoFPHeWN6J5vnCiKhEp2BlcgwFb42acbWbom5RRCsy6DMJkynitOXvUzDv16JPorT4M7lRYER1r5LI/5I78/rfnW75xZTRzfNmNlhW3fZ4Sw0mqUVolM66J1REBfNKFCS0qU0Est5F0O2O2suwWWX8xlLMIgFa4SdR8CrHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xconn-tech.com; spf=pass smtp.mailfrom=xconn-tech.com; dkim=pass (2048-bit key) header.d=xconn-tech.com header.i=@xconn-tech.com header.b=Vnv+s0Si; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xconn-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xconn-tech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xconn-tech.com header.i=@xconn-tech.com header.b="Vnv+s0Si"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2166651f752so57824485ad.3
        for <linux-cxl@vger.kernel.org>; Fri, 07 Feb 2025 13:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xconn-tech.com; s=google; t=1738964170; x=1739568970; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:msip_labels:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=em4d7q4/4/lk2sf/I7ehijLHymxDwUlgAoCxq6MRmxQ=;
        b=Vnv+s0Sir1HuRYK+GUvDExmB5B8OO8xpAQZfvRkt9SP9fD/av/GrcfN0QIktcqTF0z
         eZ8E8C+7ada1BQ9N/9O7yW96jULH90unKa5BnFUEiJxP0eQYrHeculmYVW3lP5f3IyZD
         21P8VJM4WgPwD0bEWmnbY8ZDgWVxvjpfEd9HZO9Yc7G8gbRrjJjSGsyox92JAe9c4mux
         Zq0g2pF8fonvE4MrboNFFH86JkHIP3HOfW1ocAxbI1u5n6FK4UTlc/BBZOw5xAJPyt2t
         hZ4sBmC6TuH0UcWF1fyc5nQ7Y/DbCFgdyMjuR+NMALKwhvWZbXjJq1QgzNsH/ZmMTBf2
         2gAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738964170; x=1739568970;
        h=mime-version:content-transfer-encoding:msip_labels:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=em4d7q4/4/lk2sf/I7ehijLHymxDwUlgAoCxq6MRmxQ=;
        b=CY+bM2hoqQE2sttLrQzhk1LO+Au0yVs3Io24d44jIuibTEG4nG8rXT3a1oV/gooxDa
         BDW+UqkjvaRI+7rg7du9R8iYU8nOQJkaLLhjb7KF0q4LMAFXAS7AezBqXkClQ5vOMCfL
         qMgvozY9l59XBStB8PSO2Bv/jhJ1mtjRKPWnZ/ezvTmQ06iYP5UeY7xK5obkuhrJnr5k
         yPbJ1i1cvrgmsDXPpcWJIQziWiLjKeDy++3OxRvZb1auLE2IhvsFx1RFzeaQ0s5JcIgm
         SsezwyO6fcLxG9RjfZMOyZ3OEMBf41CE3jRndmgzO/RI6GRrUy2kFJHwOafvnDz5HJ2M
         1t4A==
X-Forwarded-Encrypted: i=1; AJvYcCVgsMHe4b7fadi/bOqF0PXuKiIzRXfViTuIilkOwvOd5/ZCbNkm+FQJ01H6IzLZyA9wa0jIQys2aTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHjFcWc8fAGo7lscS2428BqIoZfWV8VDlao4bHIjoQd6HcILlT
	sdAZffqRP0emhT0CavwQUtfIOwukJo6+m1Fye90f0Cv7LtpaRqGbbuYeesEaxxo=
X-Gm-Gg: ASbGncu0u2a3nudxri8qJndi6NpYSGx8F/OHt0Ii2jaEnqcCOtB5d+riMF52m74s40U
	SzTNwQdmf3dOJ6dcBTWDHtHj1r+D+ay2mCJlWd73rTTe3L3s60ALlYxHSbnG1ARJOM6iXiiYnKN
	+foIbjPQ22a/RtiDzcdQDksa8+JYSlqMxTDDk8IV33snVMhGgjn2dvO056fmvy6R5pXTG2PQ87v
	Sykf8foQLwys8hBL3amY/QWKuvyKCylEBG15LIemrO7oPtXZh4UHISwn/5pfUl66rgA7NKrirML
	AFy6cBhy2mGA1TWdyHfmXs8Ep/RtaOQqwN73NqvfQYE+UWtVkNAAai4vzweDmLz8V8zm2vKR0we
	f1g==
X-Google-Smtp-Source: AGHT+IEWcjeawcc67xQoNXRrnfhYE5btFNPyPq9AzMglKKfStP7mN8XiNHG32+hzgHqIV2e29MeMCw==
X-Received: by 2002:a05:6a21:158c:b0:1e1:aef4:9cd0 with SMTP id adf61e73a8af0-1ee03a24237mr8893146637.3.1738964170273;
        Fri, 07 Feb 2025 13:36:10 -0800 (PST)
Received: from BYAPR06MB4135.namprd06.prod.outlook.com ([2603:1036:a03:12::5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048c1623dsm3546663b3a.132.2025.02.07.13.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 13:36:09 -0800 (PST)
From: Jim Kao <jim.kao@xconn-tech.com>
To: Gregory Price <gourry@gourry.net>, Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Fabio M. De
 Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>
Subject: Re: [PATCH v2 03/18] cxl/pci: cxl_hdm_decode_init: Move comment
Thread-Topic: [PATCH v2 03/18] cxl/pci: cxl_hdm_decode_init: Move comment
Thread-Index: AQHbeXZwobcdjmN85EOzIwKkaoKPi7M8AI+AgABc9E0=
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Fri, 7 Feb 2025 21:36:08 +0000
Message-ID:
	<BYAPR06MB413558D98731EBD422CF24E4A1F12@BYAPR06MB4135.namprd06.prod.outlook.com>
References: <20250207153753.418849-1-rrichter@amd.com>
 <20250207153753.418849-4-rrichter@amd.com>
 <Z6YurVy_K96jet3U@gourry-fedora-PF4VCD3F>
In-Reply-To: <Z6YurVy_K96jet3U@gourry-fedora-PF4VCD3F>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator:
X-MS-Exchange-Organization-RecordReviewCfmType: 0
msip_labels:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Do we have any limitation for HDM Decoder Range in Linux Kernel ?=0A=
We has observed that Linux might be hung if range is larger than 8TB.=0A=
=0A=
Jim

________________________________________
From: Gregory Price <gourry@gourry.net>
Sent: Friday, February 7, 2025 8:02 AM
To: Robert Richter
Cc: Alison Schofield; Vishal Verma; Ira Weiny; Dan Williams; Jonathan Camer=
on; Dave Jiang; Davidlohr Bueso; linux-cxl@vger.kernel.org; linux-kernel@vg=
er.kernel.org; Fabio M. De Francesco; Terry Bowman
Subject: Re: [PATCH v2 03/18] cxl/pci: cxl_hdm_decode_init: Move comment

On Fri, Feb 07, 2025 at 04:37:38PM +0100, Robert Richter wrote:
> The comment applies to the check, move it there.
>
> Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Gregory Price <gourry@gourry.net>

