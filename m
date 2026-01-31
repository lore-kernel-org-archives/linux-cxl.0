Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com [209.85.160.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8F676026
	for <linux-cxl@vger.kernel.org>; Sat, 31 Jan 2026 15:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769874557; cv=none; b=gyLeDivax517m73pNmP6VOA2LAHBmgMovBZfHvJuJnCb1d3Mq2fzoyfF9Ute49F+U5tBu1s7pjEqkA3n1yEN9qtZUKyvhmAWPmmNe32vVh6m0tZWRN51ZqAEUJ4oLA9056zeO75EkEjZLHnavQEfjAS+ogZ87Ub6GUtuJImqk+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769874557; c=relaxed/simple;
	bh=e+sxkpcgy/UPsU5yHQm62w8F2taYB4oVjMWquEjSD2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qdo5Vlf8SImYA6vwiWH4YIXLpeOwkrlJ/MFw2359VEfAXBXUdvHHDelsBjtzo/nrzJx3g9b4djNfBXtlV+PQEqnqxmhlr5FJLPdVI8CyVGQo16uUpuqTG8GsjzK7R1sNaYUs7mOGczR+3dUJj6hvvK5A3ifQIeFCeplK9TKA5ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=aAM9CsXu; arc=none smtp.client-ip=209.85.160.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="aAM9CsXu"
Received: by mail-qt1-f194.google.com with SMTP id d75a77b69052e-5029901389dso23679161cf.2
        for <linux-cxl@vger.kernel.org>; Sat, 31 Jan 2026 07:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1769874555; x=1770479355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bPF4ycLGC9KPEPRyh9m491Nfyeff7N7K51LyrOvrdH8=;
        b=aAM9CsXuXKJWgqH2KFVFfkzDl9lr/1lV7RjRpUmruQBRyvuDP8MdDwOrZCWYbB6tgh
         4dJCuEydAKhgmmcDCClephCme6ywtIBoLZlqDunFrGyrsyZFsyqKsahro99TATVKebT7
         LVoOI1ax9XqgzKS0P+K0QRq22UXvY3GSFr0qKF642uLVyu4Q0hJVV/wW0LuhxBLmkMv7
         aNnSRCpVQNuzs3vWzTu9d2KWBs/o51Ur97PWfdfe0XpAUeeP1zNU5s4UMJhCmwzQrXgW
         EE7DKGXbaqrtpo0usf7PZBmtqukEhXo5ITNaDk8hT4Hzr4rMBdLQIlCWVS3Zgl0pOCN/
         ADgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769874555; x=1770479355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bPF4ycLGC9KPEPRyh9m491Nfyeff7N7K51LyrOvrdH8=;
        b=EpLw9tsMVmVVf8sktUGPmLKO0WlIMVMYRx90f0CyhWed+bmvlU7MpPP9mWfyzI8GB3
         zUig9CYuJrD9YNe3KLRFFFWGJ8aysLN3Teko/sSV5TViAHaw1GCHY1yXx9wLadwHhHjk
         QrvsGiOPdcvRmEbhsT7YVitFKhq8at7ZIRU18Ff7reZd6zgAGYsaveSZ1n8BhE2pKME0
         JF0CaTFqCfOqgRG8LHKF1mhh0SgFV/3hOL2C+6iXxdrMo0PI0dyowujJHVyGcONTe8Pi
         Do1kcK7wwc0QIMnrEg30ajUCTvUcbdw91qxOnsFISVvqE/zLEMTWe7TkWcOzL7RR52EI
         2CSQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/50Xx5hD0/s/qELE1ZSiOGVG5Fb6lSpQZOlRhpCgq4EnwcDju80EN/V4/hEtNjN+GufbaEsSBOpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHTJ9plIqF1Wp0FsyQRyRw3PUDdVranvHPlTNeL9U3khDOOnUt
	RFGyV8Xl4JfBRQfCvqbIEkZRQ8bJEMlKlPdczP6eBLjflzNA8bbZ/o/lyxG3zvuM+053rmQGJhH
	sFKc+s0TElw==
X-Gm-Gg: AZuq6aLY2m9xYLLQUIrn6CBiyVAfsbZpW5mQrUBJJTc9awtPdKVcaXeXmS5y94F1H6u
	hvBSDSkGp9j0tLmAaRj2HSSqG2wZzNhfLr5PITUN+XWE5yuof3n9SHtgLvmQenztfKdOD76IToz
	9X570EcO6cePj9RnissMLz7asB/xzWX8R87Ohgj1S3iMSVAMJmV3uEQeRM8c0K/Nh/afRS3Vyh/
	LsXbVvHSJfilwjOBvY+BI4i41bKZ3ia/4rTV/yF1zIOFpuMWZS2C3S9MQVxKw8LcXkYcC/ZdmBt
	LSLzpBCpwMpHfaFumScRkrlLpP/ej9NstYGwkJeLuyGBC3fKVVvXnTeBjA3AXT/XRslgX8lW/F7
	SFZQtDtuldpxXLhpW9KzhoaE14ikpJTvAeAchynnVta66oiK7pnKQQCuBE2IRAroYHYClmWoQpi
	uAGRMIGpft4PMQRPxPM94y2yOs4XlrGvgrt0PFmU3kR3AbaK7DwEYu0Q34hvKnTW1Xj9nVMg==
X-Received: by 2002:ac8:5889:0:b0:502:e07b:2f0e with SMTP id d75a77b69052e-505d22ddd15mr74609341cf.84.1769874554641;
        Sat, 31 Jan 2026 07:49:14 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d36a9bdbsm77372056d6.11.2026.01.31.07.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 07:49:14 -0800 (PST)
Date: Sat, 31 Jan 2026 10:49:11 -0500
From: Gregory Price <gourry@gourry.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: dan.j.williams@intel.com, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/2] cxl/region: Unregister auto-created region when
 assembly fails
Message-ID: <aX4kd-S3PQTTWfol@gourry-fedora-PF4VCD3F>
References: <3bcc5143777acc6d45675d78dd8c57079406bc53.1769746294.git.alison.schofield@intel.com>
 <2a613604c0cdda6d9f838ae9b47ea6d936c5e4ce.1769746294.git.alison.schofield@intel.com>
 <697cee39ed313_1d6f100bd@dwillia2-mobl4.notmuch>
 <aX1VMDh9IY4eg1h_@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aX1VMDh9IY4eg1h_@aschofie-mobl2.lan>

On Fri, Jan 30, 2026 at 05:04:48PM -0800, Alison Schofield wrote:
> 
... snip ...
Logging in on a saturday, will respond fully on monday just wanted to
inject a question for the masses here

> When auto-created region assembly fails, 

I wonder how many work we want to do to try to make the auto-region
path more reliable for complex setups (interleaving being one example).

In other paths, in particular when there is some implied use-case for
the device, we already take the opinion the BIOS should do nothing.
Should we draw a hard line on when that should be the official opinion?

i.e. auto-decoders should be intended for trivial SysRAM regions only

(especially given that a user can't even select zone-isolation except
 via a global kernel build option that affects all hotplug memory)

~Gregory
