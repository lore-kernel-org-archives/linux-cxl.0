Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E54313E10
	for <linux-cxl@vger.kernel.org>; Wed, 29 Apr 2026 13:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777471081; cv=none; b=Hqvzgm9egIeq4XUroIDuIQjH4NeCHzFS+qQKPhbNoNKk84r+g43FX26ocqhNftBdZEHceevj8wC6nIpTKciMhbxZWfS2WgOmkKbDdDA0Y85j0OCWfjM5jfIh62Dy1I2hsWntQAdCvA2BPZFO/WQ/PKj67I6vsJMOUk+eBlR8atA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777471081; c=relaxed/simple;
	bh=/DTwXpM7O/15uFE8pisXtbVYHf+9FqV1p1pg1lV5a3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aqkjhYKiHe+xVW/iXdFXyXtlgv9+vOLs20BRHvnDu8unP6ASaFV8thLgSbdZvUWw1RBpZnRThMBe8TPHZfl11ZH905mgEuV1wxg1Ex5wmCNFe1nwJ3BGb9NXSuEEkeMq0fpKrf31X4MQog8thraZmO7/0jY5BbJkx5GwFQ7oA2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwSW+tGu; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwSW+tGu"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43cff5dafc3so9911618f8f.1
        for <linux-cxl@vger.kernel.org>; Wed, 29 Apr 2026 06:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777471076; x=1778075876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hCHtycy4An6frL027okw83jsdSBE9b+29TxohlVbQig=;
        b=SwSW+tGuqg3UH3qhAA8lm1WA5EARzYbtboyTnufTZJ1cO70G+8AHm5Div6lmkWB1g/
         uoqmK5V5UT3kl1t92eT1jqemb36pLOvMVySMvy6RAnmTsz5wCwxZg0vGFdHPLy8gpgDz
         bowi3lBVUQKYKzJ74lGM64IuK3KDpWJmFO22Wz5rtKM8oriGwhximhWhxCmnlKStHtlz
         5obxmhsxBcQIZGACPO3Id1uSmtV3ss6HJhi7CBc6A0DyN20YqcWKVzJ4WKvuAfsoE/vF
         fJMuhI81gjLqUxVRguKaoKsxCldFpBm2M9mXFuZbKjdR57QC9tl9phITr7FQJSzDQ3n3
         y/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777471076; x=1778075876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hCHtycy4An6frL027okw83jsdSBE9b+29TxohlVbQig=;
        b=bmVZGKW6yo0LYjiOyLp05meoxYC33fwIx0XpO9sjDF6bIlj0avmWjMwmcogEW7dVgm
         TTp+0oktUtkumCdffEfxs26jsNoTdr07BtV2QDChw0+ok3j3cnDkMRmWoH7qeDouV114
         qhlIO4ux9KpIB27N7YwoBQDH0S4uD+5C3dEdwTsS1W7Gnjjb9E13sL1HRtVB+8NbkoD6
         p7fMjTNNl+kTuE9d3QVL2YIBBggMGMId01HobrkbpRlrXWmuDJYhDivt4GhmpB9zq7m2
         hXYQjT7/Nbk5+ulwx1FJF+jj5v2s0YUqQ2Ed6m6jtoUvUdxutIQ2O+bm4S0OotJaeTiL
         ad0w==
X-Gm-Message-State: AOJu0Yxcxuc3K+OMiWSGftp0dNYmlC1sTWquRIMlptXwXuipL03vZxam
	Nr78CTvNr189XmWwoz/zM8+mu+OFS+NdHHKbB9LrtAJYjJGdNulhs8UWv+zUvdBb
X-Gm-Gg: AeBDieueHqiXpbm+w1OBKl5VbqLcoTDCk2d9jIW4BI/zvhHDI59Lf4BAoEYoCIS0WSY
	ig1giWqQ7PFgSjYbby1wnpYdrrn12QgzN4+vzjP/Btn9NCnNoy2j4fBW/aHjs3p49hqh70IQJWI
	sfpC99DOe69/SQ8QbqMgj6p5LdBP0kEmVVhHl78tSzIdnnp961Cc/KEp3C1h6QNbxi2/KEpq+aM
	cxZK1jhp3cBvLu6livYPhi4IF4u/njoR1aHbUi+99FhI86Lh8E+Iytayo9ofQeb8qD4d9lqwA1Q
	bKUf6a8SDlxvpqK5/jXhWAkt0FkwfOdErTVsUch/Wqe0KHk5oBpiQjhysuzMPjQC7kftFej1o/Z
	/x4FJaypJOw9Vbc8ZVjC1eNnmDQVn5q2htofmJzFSpaz6mqrS299gXr+9aIseDqW8oyDONRbw0l
	f7BXfFHehPCi2Ts393S7BXVtAeUh3jadNcNLx1xRDHjCMZuW4MtQpXtYvI7cGmnM9WN8rmVd4H
X-Received: by 2002:a05:6000:1843:b0:439:b8b2:fad0 with SMTP id ffacd0b85a97d-4478e6b3b9cmr7209099f8f.5.1777471075822;
        Wed, 29 Apr 2026 06:57:55 -0700 (PDT)
Received: from node1.manccluster.local (revolution.cs.man.ac.uk. [130.88.198.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b3d48517sm5205950f8f.5.2026.04.29.06.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 06:57:54 -0700 (PDT)
From: Joshua Lant <joshualant@gmail.com>
To: linux-cxl@vger.kernel.org
Cc: qemu-devel@nongnu.org,
	Jonathan.Cameron@huawei.com,
	arpit1.kumar@samsung.com,
	Joshua Lant <joshualant@gmail.com>
Subject: [RFC QEMU PATCH 01/10] docs: Add documentation for cxl-vcs-switch
Date: Wed, 29 Apr 2026 14:48:35 +0100
Message-ID: <20260429135717.3048713-2-joshualant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260429135717.3048713-1-joshualant@gmail.com>
References: <20260429135717.3048713-1-joshualant@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Joshua Lant <joshualant@gmail.com>
---
 docs/system/devices/cxl.rst | 90 ++++++++++++++++++++++++++++++++++---
 1 file changed, 85 insertions(+), 5 deletions(-)

diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
index 32b1b5d773..9e8452e576 100644
--- a/docs/system/devices/cxl.rst
+++ b/docs/system/devices/cxl.rst
@@ -119,11 +119,11 @@ and associated component register access via PCI bars.
 CXL Switch
 ~~~~~~~~~~
 Here we consider a simple CXL switch with only a single
-virtual hierarchy. Whilst more complex devices exist, their
-visibility to a particular host is generally the same as for
-a simple switch design. Hosts often have no awareness
-of complex rerouting and device pooling, they simply see
-devices being hot added or hot removed.
+virtual hierarchy. Whilst more complex devices exist (see VCS
+Switching below), their visibility to a particular host is
+generally the same as for a simple switch design. Hosts often
+have no awareness of complex rerouting and device pooling,
+they simply see devices being hot added or hot removed.
 
 A CXL switch has a similar architecture to those in PCIe,
 with a single upstream port, internal PCI bus and multiple
@@ -467,6 +467,86 @@ Example configuration:
 Guest OS communication with the MCTP CCI can then be established using standard
 MCTP configuration tools.
 
+CXL Multi-VCS Switching
+-----------------------
+
+The cxl-vcs-switch object allows for a Fabric Manager to dynamically reconfigure
+the switching within a multi-upstream port CXL/PCIe topology, This moves beyond
+the static switching configuration described above. The use of vcs=X on an
+endpoint device indicates that it should be hidden from guests at boot. Each
+upstream port with vcs=X set will conceptually become an upstream PPB. Any
+downstream port that is connected to an upstream port with vcs=X set will
+automatically become a vPPB for that VCS. The overall cxl-virtual-switch has a
+single CCI mailbox used for config/status of all ports within the switch.
+Setting local-fm=true indicates that this QEMU instance has the CCI mailbox
+attached. Setting it false will create listeners for commands from a remote
+QEMU process (yet to be implemented).
+
+An example of how the topology is described on the CLI is shown below:
+
+  -object cxl-vcs-switch,id=vcs0,usp-ppbs=2,dsp-ppbs=4,local-fm=true \
+  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.0,hdm_for_passthrough=true \
+  -device cxl-rp,port=0,bus=cxl.0,id=root_port1,chassis=0,slot=1 \
+  -device pxb-cxl,bus_nr=22,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
+  -device cxl-rp,port=0,bus=cxl.1,id=root_port2,chassis=1,slot=1 \
+  -device cxl-upstream,port=0,sn=1234,bus=root_port1,id=us0,addr=0.0,multifunction=on,vcs=vcs0,usppb=0 \
+  -device cxl-upstream,port=0,sn=5678,bus=root_port2,id=us1,addr=0.0,multifunction=on,vcs=vcs0,usppb=1 \
+  -device cxl-switch-mailbox-cci,bus=root_port1,addr=0.3,target=vcs0 \
+  -device usb-cxl-mctp,bus=ehci.0,id=usb0,target=vcs0 \
+  -device cxl-downstream,port=0,bus=us0,id=dsp0,slot=3 \
+  -device cxl-downstream,port=1,bus=us0,id=dsp1,slot=4 \
+  -device cxl-downstream,port=0,bus=us1,id=dsp2,slot=7 \
+  -device cxl-downstream,port=1,bus=us1,id=dsp3,slot=8 \
+  -device cxl-type3,persistent-memdev=cxl-mem1,id=cxl-ep1,lsa=cxl-lsa1,sn=99,vcs=vcs0,dsppb=0 \
+  -device cxl-type3,persistent-memdev=cxl-mem2,id=cxl-ep2,lsa=cxl-lsa2,sn=100,vcs=vcs0,dsppb=1 \
+  -device cxl-type3,persistent-memdev=cxl-mem3,id=cxl-ep3,lsa=cxl-lsa3,sn=101,vcs=vcs0,dsppb=2 \
+  -device cxl-type3,persistent-memdev=cxl-mem4,id=cxl-ep4,lsa=cxl-lsa4,sn=102,vcs=vcs0,dsppb=3 \
+  -machine cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=8G,cxl-fmw.1.targets.0=cxl.1,cxl-fmw.1.size=8G
+
+Example topology involving VCS switching::
+
+               +--------------------+  +--------------------+
+               |   Host Bridge 0    |  |   Host Bridge 1    |
+               +----------+---------+  +----------+---------+
+    +-------+             |                       |
+    | MCTP  |             |                       |
+    | USB/  |  +----------+---------+  +----------+---------+
+    | I2C   |  |    Root Port 0     |  |    Root Port 1     |
+    +-----+-+  +----------+---------+  +----------+---------+
+          |               |                       |
+          |               |                       |
+   +------|---------------+-----------------------+-----------------------+
+   |    +-+--------+      |  cxl-vcs-switch (vcs0)|                       |
+   | +--| CCI MBOX |---*  |                       |                       |
+   | |  +----------+      |                       |                       |
+   | |  +-----------------+--------+      +-------+------------------+    |
+   | +--+                 |   VCS0 |  *---+       |             VCS1 |    |
+   |    | +---------------+------+ |      | +-----+----------------+ |    |
+   |    | |                      | |      | |                      | |    |
+   |    | |        USP 0         | |      | |        USP 1         | |    |
+   |    | |                      | |      | |                      | |    |
+   |    | +----+------------+----+ |      | +----+------------+----+ |    |
+   |    |      |            |      |      |      |            |      |    |
+   |    | +----+----+  +----+----+ |      | +----+----+  +----+----+ |    |
+   |    | |  DSP 0  |  |  DSP 1  | |      | |  DSP 2  |  |  DSP 3  | |    |
+   |    | |(vPPB 0) |  |(vPPB 1) | |      | |(vPPB 0) |  |(vPPB 1) | |    |
+   |    | |         |  |         | |      | |         |  |         | |    |
+   |    | +---------+  +---------+ |      | +---------+  +----+----+ |    |
+   |    +--------------------------+      +-------------------+------+    |
+   |                                                          |           |
+   |           +----------------------------------------------+           |
+   |           |                                                          |
+   |           |            -                    -            -           |
+   +-----------|------------|--------------------|------------|-----------+
+               |            |                    |            |
+          +---------+  +---------+          +---------+  +---------+
+          |CXL/PCIe |  |CXL/PCIe |          |CXL/PCIe |  |CXL/PCIe |
+          |  EP 0   |  |  EP 1   |          |  EP 2   |  |  EP 3   |
+          | (PPB0)  |  | (PPB1)  |          | (PPB2)  |  | (PPB3)  |
+          +---------+  +---------+          +---------+  +---------+
+                 PPB0 Bound to VCS1, vPPB1. Others unbound...
+
+
 References
 ----------
 
-- 
2.47.3

