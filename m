Received: from cmccmta2.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CF01F5E4
	for <linux-cxl@vger.kernel.org>; Wed, 20 Dec 2023 08:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86582a222aac-4eaac;
	Wed, 20 Dec 2023 16:13:22 +0800 (CST)
X-RM-TRANSID:2ee86582a222aac-4eaac
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from smtpclient.apple (unknown[10.54.5.252])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16582a22046c-b0276;
	Wed, 20 Dec 2023 16:13:22 +0800 (CST)
X-RM-TRANSID:2ee16582a22046c-b0276
From: lihuawei <lihuawei@cmss.chinamobile.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: How to emulate write with cxl_test memX in kernel
Date: Wed, 20 Dec 2023 16:13:11 +0800
References: <149A1DCD-BD15-4CEB-A509-D7F2FBBF0D83@cmss.chinamobile.com>
To: linux-cxl@vger.kernel.org
In-Reply-To: <149A1DCD-BD15-4CEB-A509-D7F2FBBF0D83@cmss.chinamobile.com>
Message-Id: <6FBE1CF7-F4A6-4187-8065-524DE3F55AB8@cmss.chinamobile.com>
X-Mailer: Apple Mail (2.3731.400.51.1.1)

Hi everyone,

I want to do a read/write test with cxl_test in kernel, but got an error =
log like: "cxl memdev: action_write: mem0: has active nvdimm bridge, =
abort label write" when executing "cxl write-labels mem0" cmd(with the =
kernel version v6.5.0).=20

Can we disable nvdimm bridge? Does cxl_test support write mem emulation =
now?  Or other advices?

I have poorly understand about the cxl_test/nvdimm/cxl now.

Best Regards,
lihuawei



