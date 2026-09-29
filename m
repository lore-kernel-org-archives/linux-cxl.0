Received: from outbound.baidu.com (mx13.baidu.com [220.181.3.100])
	by smtp.subspace.kernel.org (Postfix) with SMTP id EC14F429CFB;
	Tue, 29 Sep 2026 03:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.3.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790651897; cv=none; b=Nj6P6NsY0Ki0+IlpzEde3CJ5+vh9GjsCgoDQ/XsZq0Tx4uxo8UKhgRHustyYCzNVe8tSqL/FpGEeMU5BBuB0HYRdcUchip1AubUptK5t0PeLp6Lm/bX7KIF3YfipasEOd7af2W9pL3Q5b6mGe+FOaJ8vR7RQHqNcbASBgfvDsaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790651897; c=relaxed/simple;
	bh=6AjJ821OU4QvFaiWOc/pUE94hqfpOvxPT4btsaZx35g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=edXZYaA7F2uwMGVhmwIMVbpnUtaPMimpYlybXQaqwVeVslohqm9Gf3A+IvKVnj82Hn0nky3DCLFKTKvb+7FjR30gSKlUMg4Nvxx1eLlWk1HUmw31KzSGyFwlYh4cNTXJTxyWjhQ9NmYaz3iw3Nm8/0ojAexxyjdvjiFu446B0vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=WHvv38e8; arc=none smtp.client-ip=220.181.3.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="WHvv38e8"
X-MD-Sfrom: zhangyili01@baidu.com
X-MD-SrcIP: 172.31.51.15
From: Yili Zhang <zhangyili01@baidu.com>
To: <dave.jiang@intel.com>
CC: <alison.schofield@intel.com>, <dave@stgolabs.net>, <jic23@kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shiju.jose@huawei.com>, <vishal.l.verma@intel.com>, <zhangyili01@baidu.com>
Subject: Re: [PATCH] cxl/edac: Bounds-check ECS threshold index from device
Date: Tue, 29 Sep 2026 11:17:42 +0800
Message-ID: <20260929031742.14302-1-zhangyili01@baidu.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <51e4cfe6-b3c7-43ff-8b1c-512cfb23b9be@intel.com>
References: <51e4cfe6-b3c7-43ff-8b1c-512cfb23b9be@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc5.internal.baidu.com (172.31.50.49) To
 BJKJY-Exc19.internal.baidu.com (172.31.51.15)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1790651870;
	bh=6AjJ821OU4QvFaiWOc/pUE94hqfpOvxPT4btsaZx35g=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=WHvv38e8EZ7uc3S/4AokIlzJZmBTKP+XZo9pWZ52KbXqyl+Y3mf/4w1Fzl6Jz04qc
	 MbHCi1Ted+i0/V9XC6c4ltBsWuFRh0sLT1NEZG1sUVWyND+4ILwTaA3UZWrYCSC0zi
	 eMILSRfRJDzXESkjYpD6T7KfgYGyN4XUjRZ8Kd7Q3ceZ8jwnVpr8xJi7BNAYexhfUz
	 CYL2nqOfjr1yJD3AmkL82rEKUACNPmUrQth8eSUoVyri24RTpr6maVDbb4GOddtEd5
	 if4xcn3eyTOxLecWZlwzRaCIgBE+wXrovPE5QJH8Iyg6IauiqBgw822YBIZxJyIcYP
	 Khyf95cnWW5hw==

On 2026-09-28 11:21, Dave Jiang wrote:
>
> On 9/28/26 12:35 AM, Yili Zhang wrote:
> > cxl_get_ecs_threshold() extracts a 3-bit index (0-7) from the
> > device-supplied ECS config word and uses it to
> > index ecs_supp_threshold[], which only has 6 elements. A device reporting
> > index 6 or 7 causes an out-of-bounds read of adjacent .rodata, whose
> > value is then returned to userspace via the EDAC 'threshold' sysfs
> > attribute (small info leak and wrong reported threshold).
> >
> > Return 0 for indices outside the table.
>
> Why return 0 instead of errno?

The threshold count field is 3 bits wide, with encodings 0-2 and
6-7 reserved. ecs_supp_threshold[] is a sparse array that only
initializes entries 3-5 (256/1024/4096), so when a device reports
one of the reserved encodings 0-2, the current code already
returns 0. The patch just extends the same treatment to the
remaining reserved indices instead of reading past the table.
0 is also not a valid threshold value, so userspace can tell it
apart from a real one.

Returning an errno would additionally require open-coding a
separate getter for this one attribute, as it goes through the
shared CXL_ECS_GET_ATTR() macro, which cannot propagate errors.

So I'd prefer to keep returning 0 here.

Thanks,
Yili
