Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFE43C0624
	for <linux-cxl@vger.kernel.org>; Fri, 19 Jun 2026 17:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781891199; cv=none; b=REuWw+ZZImhy6dE5V/X80lsjgBioWid8Wpvp60b2I4VN2IpyvtOxiT83lrjrSUSrthsdUzmXo9KUeXA01eKwJRJ5RMj9JToETO5mOHjHLNGhTo4YPNp10xOLfrv0Y7RsaWC9SSberAgvfC679ozal82IOVRfvmpW6JRixEbcxAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781891199; c=relaxed/simple;
	bh=H7f14CYwNP46ECpdeY80MJ+vB0wytZ/WUeIVEgw1f+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i03CR3On5I/ZkA6/3i2SAz9R3o4ucFB7SoDG9zMnrlrLILXZ4ABhHp6tjTEddVY0rPqEwMc8ryQywODt1aRmK34/UIwSi5jr4FkC0VE889PyRYlRIO6kCP0i3141ax2RQQtjbOBRXH8csdR14/t6pYTOr0hEXZ8xdfhCp0GSFD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/eQFjIG; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/eQFjIG"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490b7866869so22588545e9.2
        for <linux-cxl@vger.kernel.org>; Fri, 19 Jun 2026 10:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781891196; x=1782495996; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=H7f14CYwNP46ECpdeY80MJ+vB0wytZ/WUeIVEgw1f+A=;
        b=R/eQFjIGJOmwIPpGAgwCpcPD7gX90JNhp63BcLpbxsSmEfYWhC23L8ze/2dfcH9zMN
         KJIGipk/2pZUHiSDNn6As+WfrOIekJ+SNEGKEK6+YnM6mX47b5wMXv77XGvIN1zaqIWw
         WGUekG7wyIg7AfKUrV/HQ+VswK4gC7W4UgCknjghxhb12acvDOKqh1Ffi8QHWyUMbCnw
         mPg6vw/nkHpOJLF1wurbV8ZZPiOmTu3Stw0F5Rlyf4fUFBZ9e5RULvZG9K0yzI3mlkSA
         57owJPUssf1JYAjTUpI8kqH+VJ+GYZbxgzEgDoQWenMso/gtj/Kbh6nISmYtAn3pGASU
         WqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781891196; x=1782495996;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7f14CYwNP46ECpdeY80MJ+vB0wytZ/WUeIVEgw1f+A=;
        b=jQsbzeLmom0/GjdQv2SRJddnalDGbIVGhK40JmuCL2I9m9fx7g4NBTRiFulABpLaR+
         aHfDjj/t6hoZMRQO9lgnekT6wnoVgNRayHOUwI7kHy/8EJKUFO1Cwpf9THZC96sJ+R+b
         dIoA3Kl8WF+y3Lec/01H1HveZUZYraiNUyq/9eY7PvU4W+FVmIx8aRZ0rVOCVKRKxbLM
         P03HX6cIXm3emGrK7gJQDtheVZ+v6TIkCAg2OKiNkzsKfIIIlxrz1+PYbWMfV4/IBKFI
         RG1iCQlkm+82q7isp9jWLYPn11IFamneiC/4thyYKlBSmnoV0YopCFbELKi7PYHIWJfb
         2KcQ==
X-Forwarded-Encrypted: i=1; AFNElJ9yqrBBTM0+YFNSqd8q/fT8CxPOWgBXMgJL/LNTSeRotB9evWAEDj7PFbHemRJb1a4x0AX0XKoOqtI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlRGO5IkD1XR9wo+sQ971BorRtk2fdIyS52nqGE1mpl5168N6r
	DWrqL77l43d2cw+UdpCLoNIVt2I6VVqRRVH+sTtZ0fKMm+yuMSIqSap1
X-Gm-Gg: AfdE7ck3ATj7XXSW+VgOOF833CwqhJxsz2kTzz+uU1m7aBcrIzOoz7FavTdMxctyo8h
	h7LCV7xwKMlCK+gn2T6h23mtxZ4Ed+86vhcd06kk/OiZmUybOWC2Ek0L6hV7pzeEsPtqbui3jXf
	0RP4bVpx9tBTrKPyl1QOYcS41tTZDM0keXX91JDg31Hgu0NMzMDVhRb3JxgAtzR5nGRmCFu9vLz
	AgkKc2E5QUgSfozLJTtuoJ16FFyF6kVZSVN0UeFkWWiYSQoHrCerrdS5vY6CRaK3Gy+MPv+BUFW
	IFzEnbxG/JIvAcxHax1aFZEq86T7MFGNfkv+/GYsqUsEafDhdwORyK1jtIoqATFu9dVWYPDraVi
	EFfHYiLiHh58Jm914hC9u2MWFjVY6S6wU6xXnXZGumTN45CTkg2UUrZuE/N2YVghoq5yfDSzflE
	m4hxdhwBk44GyCeq/La4TyNsVmZ3X9FpZwD/bq5kJb9QRXLtvGpeq0zjqd878UvkoXF1bo7OvQU
	LXtaak=
X-Received: by 2002:a05:600c:a15:b0:492:39b6:5a30 with SMTP id 5b1f17b1804b1-49242591d5dmr53790795e9.35.1781891196410;
        Fri, 19 Jun 2026 10:46:36 -0700 (PDT)
Received: from [10.128.11.42] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49249238bfbsm1569755e9.5.2026.06.19.10.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 10:46:36 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <84dabe49-8405-4213-8b73-433cf736ded9@gmail.com>
Date: Fri, 19 Jun 2026 18:46:34 +0100
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/10] ACPI: APEI: introduce GHES helper
To: Ahmed Tiba <ahmed.tiba@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>,
 Len Brown <lenb@kernel.org>, Saket Dumbre <saket.dumbre@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <djbw@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-cxl@vger.kernel.org,
 devicetree@vger.kernel.org, linux-edac@vger.kernel.org,
 linux-doc@vger.kernel.org, Dmitry.Lamerov@arm.com
References: <20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-0-91f725174aa0@arm.com>
 <20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-7-91f725174aa0@arm.com>
 <58f7163f-2fce-41e9-bc35-d1d8e6f4a298@gmail.com>
 <81dd6d0d-427f-49ae-9573-fbe84dc2185a@arm.com>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <81dd6d0d-427f-49ae-9573-fbe84dc2185a@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/26 16:45, Ahmed Tiba wrote:
> GHES_CPER_HELPERS is intended for both the ACPI GHES path and the DT
> firmware-first provider, so I do not want to tie it to ACPI.

So what's the plan to fix the build error when ACPI is disabled:
https://lore.kernel.org/all/0f131ee4-d335-45d2-b6ae-49c18df1353b@gmail.com/

- Julian Braha
