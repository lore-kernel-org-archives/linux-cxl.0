Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E4748122D;
	Fri, 15 May 2026 13:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778853398; cv=none; b=ty0kKVL3UoSN/MjiCjWtMpZWclTWXRGqbUjnRL69z9qaqNlm2Fr2zZ/NXGfHvee60h44ur0lTGBlHWa+uIc4oxa57g6lOaxNErn1bBK0kohZMnFXxlrt/Roj8l5AwKwdBUQ22KGqzFHG0NR/8EU+4V9lIwlPbj4ZpcoixunWaWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778853398; c=relaxed/simple;
	bh=+W+D6PIpWXO9DlRzH4ZSvQa8bIBp9pOQn0WDU5OHJuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m6zylVcoCC+G6uHC0C+lvkxJq80w+IMfbMDadS+SwlV2dd7/JotoPgJwbrh2MVS1zaViWTXaZV0RxJ8QSp5HxqB4yLogYX/z5U3Fl8llVowHTWgkrmJHuTQ7qCpLIT6JMxv6WNlGpj366n1mnq+WBXYU8ZYJX9AalxNZJBjwH54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JG77KB3N; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JG77KB3N"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778853386; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=hMlg8NpxKOQhryj84LfqoJqCjCDvbjqffeAD7JdmCZM=;
	b=JG77KB3Nr1mOr99VQIQAMUrmeO4i5PNRG4LPnnfkWNsVKGB438qbrs7RzzzqISyygHfmVF8uaNecr/LRFEitVIuCjeKZutOsSl7vAd/rYiiFl6J5IM91NpBqgHC2px5mq8SJHqK7oub56SOalQ5IAyb7Gl61zeUo2HtdrIZAdlM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X2zfiTS_1778853381;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X2zfiTS_1778853381 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 15 May 2026 21:56:26 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: alison.schofield@intel.com
Cc: cp0613@linux.alibaba.com,
	dave.jiang@intel.com,
	dave@stgolabs.net,
	djbw@kernel.org,
	guoren@kernel.org,
	ira.weiny@intel.com,
	jic23@kernel.org,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vishal.l.verma@intel.com
Subject: Re: [PATCH] cxl/acpi: Defer probe when ACPI0016 PCI root bridge is not ready
Date: Fri, 15 May 2026 21:56:20 +0800
Message-ID: <20260515135620.19429-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <agYEL3qFef-wqHB_@aschofie-mobl2.lan>
References: <agYEL3qFef-wqHB_@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 14 May 2026 10:19:43 -0700, Alison Schofield wrote:

> > On some platforms (e.g., RISC-V and ARM64) that use the generic
> > pci_acpi_scan_root() implementation, cxl_acpi_probe may run before
> > acpi_pci_root driver has bound to ACPI0016 (CXL host bridge) devices.
> > In this case, acpi_pci_find_root() returns NULL, causing
> > to_cxl_host_bridge() to skip the device silently. This results in
> > incomplete CXL port enumeration on first boot.
> > 
> > Fix this by detecting the case where an ACPI0016 device exists but its
> > PCI root bridge is not yet ready, and returning -EPROBE_DEFER to trigger
> > a deferred probe retry.
> > 
> > Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
> 
> Hi Chen Pei,
> 
> As Richard suggested, this fails for the mock platform in cxl-test.
> (stack trace appended at end)
> 
> With this diff applied on top of your patch, it works for cxl-test
> AND I think it works for your case too. With real hardware,
> ACPI_COMPANION returns the device, and with the mock platform,
> ACPI_COMPANION returns NULL and the defer check is skipped.
> 
> Try it out, and note that I didn't consider if any of the comments
> need updating.

Hi Alison,

Thanks for the fix! 

I'll test it on my RISC-V QEMU setup and fold it into v2 along with
the other review feedback (switching to acpi_dev_hid_match(),
dropping the redundant check in add_host_bridge_uport(), etc.).

Will also run the CXL kselftests to make sure the mock platform path
works correctly.

Thanks,
Pei
