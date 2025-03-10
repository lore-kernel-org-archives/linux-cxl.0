Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBE2223308
	for <linux-cxl@vger.kernel.org>; Mon, 10 Mar 2025 08:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741594310; cv=none; b=ftWYyYJY1jMx3854oA/Rmdx3IOA2w6wk5ucJ0ukvmxbsMA8FR4yFEeieCNqyfPwLfQM6pcTd2RNgbjebugfKW82M/DFkMOyrwxLu9eU55VNv/ICYsZNUoPuHOkfYlAA4vKAGWvn7E/kc/5vO34HZPR1l0jqh12e8SwNa6d6fBj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741594310; c=relaxed/simple;
	bh=evZipJUd2k+N8QHCMIjDngVMRsYVv89bzSlXpKkK5uQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=imdBANWHgp9GBp3teez7SrxhfSCOGy+RSSKHSiBAltqrTbtpnD+RGSXAruU6MO/DmDjw/O7N9PcW3oL7hmMLQvnP4HwCjBV4Fvu+vdAWH5MsC+0Ywl4AOEbsvg8wVAX8/lrWk+ZG/1F6+SBt9Xzp+0zhvvDWQ3jtUNg1jwJIOdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Lr+kdzdA; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Lr+kdzdA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1741593997; bh=1m3NpkLP/3kCEEfq6yVIpcmTeGIdXnJV/p1gVEI3Baw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lr+kdzdAwSolZjPMmgDA3ZWPUJzbKFWfeOUN5ufNg2OG9Xsc5etqcM8MDogoRQuHW
	 eQvzdWhh3p6hG08n23igfpYieecJz3ipPVuLBdw7TZk4uAmrRB4o5AQpRGx51+wqFH
	 LGaP5auHh1TQZQSXOZBa4SU3qoi7oIGyZBa7slRw=
Received: from localhost.localdomain ([2408:8409:1921:9c88:8c6b:6c8:9ab7:c93e])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id 1469C4ED; Mon, 10 Mar 2025 16:05:06 +0800
X-QQ-mid: xmsmtpt1741593906tf5rqj6n6
Message-ID: <tencent_E9F3F01E0D2303378E16505CE4CF208AA908@qq.com>
X-QQ-XMAILINFO: NzOHSugmTg7X1YVOCHdceq8Z1QLyi0d59A5grrf3cTfFXKpskIKhksx1fYvO3I
	 ij/gK6eaWDYGapxhRzn/UpsIxMAqrFgAT9Fq7ULEZ5RW1POj5fRgfT6onhddhwoV1Qb80+1pKXmk
	 mFGn/Uw/OgmgEpQeEZ76wkv22amBskHid/yKTYB40o89ypuWtQlkkkB8H66cBFxY+G4NxPaCzgv9
	 pvwcCp7lwP/B9ISvisSCnZoRkIPog6M87djiXH/Qvdr97FqO/V9YUcP4KhIjyfNUWfzIYxHqQ/TJ
	 H9JK66RVr3wYBxd0qnl9ip9gehTeW5P/1V0nY28iS4rBXjydCnlC3YpEAqpx9bl96gJJEk5xY3An
	 dCOvxnFK/2BSKepkhb1hOi0DYiOQmJPiMGlFEmCRvUSJD4sFPaV1lkEKlOBscYazKTt04PnkYtHf
	 j8JzaU0DBQ1r62gADqsXqEkAalPIvvZBpwyXxZ3ChE+udTHibw+YfwD7+y1uZvjl8f7jL6/LdpAg
	 7dscFvLVZpiXpYCj2yOcDYy+OJYmPb/rPFl04u9kXNVUQpTO8C3SN0pYa2yVLQt/pKCyZ4ivk4E/
	 f+LfYtQW8JU0ON3nOkq9I5e4rDRETnHDcJdaObKUeBiWq1+ANUjgo1LsH00lq02UxfSi/dGc0RaD
	 Kl5M+gUcb8gY0VI7UPmbQ2kuJ/IjD86Y7/KNzUCWx94LdZbU4jRFK1f86iJo331MApHse0DU3Efz
	 uZ6Ul2Du27vLEPLq1IHz+qeGaJzdnqmGMkqZaBAH663pIxZwjlEW07w41bcprFqJQxEBcs1wpDOn
	 NoeWiZTijdwdcpa3S6TJPl4TRUWVk5bG/QAEEKisqEt+fDk8qZ0iWDmt6rICPnIG/jvj66EmVal1
	 GGZaHa7DL88FFsaUPOpJalyqxN5YpH9q8ZRmoSxStQ9IvSzhojNs7j84fDvHdTWXSVdMGUHHr//t
	 cyASLnTU0=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Junjie Fu <fujunjie1@qq.com>
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@Huawei.com,
	linux-cxl@vger.kernel.org,
	viacheslav.dubeyko@bytedance.com,
	zhitingz@cs.utexas.edu
Subject: CXL memory pooling emulation inqury
Date: Mon, 10 Mar 2025 16:02:45 +0800
X-OQ-MSGID: <20250310080245.291632-1-fujunjie1@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230215151854.00003e34@Huawei.com>
References: <20230215151854.00003e34@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Note though that there is a long way to go before we can do what you
> want.  The steps I'd expect to see along the way:
>
> 1) Emulate an Multi Headed Device.
>    Initially connect two heads to different host bridges on a single QEMU
>    machine.  That lets us test most of the code flows without needing
>    to handle tests that involve multiple machines.
>    Later, we could add a means to connect between two instances of QEMU.
> 2) Add DCD support (we'll need the kernel side of that as well)
> 3) Wire it all up.
> 4) Do the same for a Switch with MLDs behind it so we can poke the fun
>    corners.


Hi,Jonathan

Given your previous exploration, I would like to ask the following questions:
1.Does QEMU currently support simulating the above CXL memory pooling scenario?

2.If not fully supported yet, are there any available development branches 
or patches that implement this functionality?

3.Are there any guidelines or considerations for configuring and testing CXL memory pooling in QEMU?

I sincerely appreciate your time and guidance on this topic!

