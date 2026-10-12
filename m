Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE89850EBFE
	for <linux-cxl@vger.kernel.org>; Tue, 13 Oct 2026 17:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791913867; cv=none; b=Q2bNFPP53lU8lStH6beCC3bDfqPKXYU6wws/lYydmIw2vBzrObRT9JYlThUcvMM/cTDJQBuKxbLtcfEQLMaJ9R2+WgCC/GdePcG3NR4doxhlfMcNeWQ6Ku97o0ROejNekXrFe9XdYr11iKhR3Oq8oJBi1Ovs52G7gspavrAfEA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791913867; c=relaxed/simple;
	bh=n72riOFT9zMszPdIbWgnFahKIsx4JheiYt11aqPFJ4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qHFNuPy2XlIDYhqqSDMGi8OCAZAOoUcXROCn2VbK2QHP3yipkDaUwG5YHWembEH5ZkL+QgZ8w7wKfGtpoDQ/DuaJsb7br2h3AAYj5Z+LrPy8eidLFNGtXPwMdEpCKYHD8I3jrj+Qb30Xci+OsK01pY4IKtETpcIUUgFdDxqr70U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TzA2a9C6; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=a5en31sF; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TzA2a9C6";
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="a5en31sF"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4E9754E4120F
	for <linux-cxl@vger.kernel.org>; Tue, 13 Oct 2026 17:51:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 231BE60362
	for <linux-cxl@vger.kernel.org>; Tue, 13 Oct 2026 17:51:03 +0000 (UTC)
Received: by mail.galae.net (Postcow, from userid 0)
	id 933B811D7183A; Tue, 13 Oct 2026 19:48:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791913862; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=LEz6fW5lydZExsmSIK9gCH0i3AJi/eLpRMeT4JJOYIA=;
	b=TzA2a9C6M9TfsMDc9kYu3fCXiytH13BN8QiPZ966qa+74oXcc/ZgcxwVRELO145BcWdgRj
	HaL3sKPCwpU/iDWrZ/l09t2w+F4mm+keq/r4I7QSUyU9orSpCHBKZlsuzcwpUuJSL5hGOL
	fQZGxC49b/6GdSLI3PeyA7ZQ2EMsaDldu50ZBIP0BPzoxcmLODvbhaufP0a76TE/jU5V0U
	SnFa5xGS7CH0YIUjvK48Wne8XSsEwZMPZscw8yNthfE5KumMx+9zWhPDISoLa6Uqmr2fB6
	jfwFfeltt809VwUqQTO6zOJ/3zmQdqZ6SzSoNOK5mIYIR7U5pRqoi1l8l0n25A==
Authentication-Results: mail.galae.net;
	none
Received: from mail.galae.net ([172.22.1.253])
	by 9e7fea892943 with LMTP
	id +NfaBL3uzGoYHxEAtaWaaQ
	(envelope-from <herve.codina@bootlin.com>)
	for <herve.codina@bootlin.com>; Mon, 12 Oct 2026 16:29:17 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9529711D70C51;
	Mon, 12 Oct 2026 16:29:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791815350; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=LEz6fW5lydZExsmSIK9gCH0i3AJi/eLpRMeT4JJOYIA=;
	b=a5en31sFtY36sewI1cQm/PvxYZivlvd53cCrweL0zm/URMGftFqsV1DZXBfwbuTH0e9ov1
	r7PABM1Eglkfz6mwnMPnO9o+/DpkMvC3LbHeHcPClWNnMIiZj8aa+XV40SKB47BQ57dyOV
	lCitia2dwRNb/QGZ4MIEIt3VIzr8uh6U6jbjg+uXVKgic7MDueWfX8yIIZAClED6LwRxhX
	XrdAW3GIuWrthaSK35MWGD0tGrSna7zEq5Um128Jhces7W9sTMHbf962aFzXmFiYEo3MA+
	GRT3rAPoMZK6Cg/ZNfa/edlJum6+5VOZrmn/OruFx8Lx0KPBk66Hz0uAZjnhyQ==
From: Herve Codina <herve.codina@bootlin.com>
To: Richard Cheng <icheng@nvidia.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Linus Walleij <linusw@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Lizhi Hou <lizhi.hou@amd.com>
Cc: driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v13 02/10] drivers: core: Use fw_devlink_set_device()
Date: Mon, 12 Oct 2026 16:28:16 +0200
Message-ID: <20261012142826.159178-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012142826.159178-1-herve.codina@bootlin.com>
References: <20261012142826.159178-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Last-TLS-Session-Version: None
X-Rspamd-Queue-Id: 933B811D7183A
X-Spamd-Result: default: False [1.40 / 30.00];
	BAYES_HAM(-1.10)[81.76%];
	DATE_IN_PAST(1.00)[27];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_NO_TLS_LAST(0.10)[];
	URIBL_BLOCKED(0.00)[qualcomm.com:email,nvidia.com:email,localhost:rdns,localhost:helo,linaro.org:email,intel.com:email,bootlin.com:mid,bootlin.com:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	BCC(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[herve.codina@bootlin.com];
	RCPT_COUNT_TWELVE(0.00)[44];
	PREVIOUSLY_DELIVERED(0.00)[herve.codina@bootlin.com];
	DKIM_SIGNED(0.00)[bootlin.com:s=dkim];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FREEMAIL_TO(0.00)[nvidia.com,lunn.ch,kernel.org,linuxfoundation.org,google.com,opensource.cirrus.com,cirrus.com,linux.intel.com,gmail.com,stgolabs.net,intel.com,zohomail.com,bootlin.com,amd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MAILCOW_DOMAIN_HEADER_FROM(0.00)[bootlin.com]

The code set directly fwnode->dev field.

Use the dedicated fw_devlink_set_device() helper to perform this
operation.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/base/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4c0c373998a1..3268e9350c86 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3754,7 +3754,7 @@ int device_add(struct device *dev)
 	 * device and the driver sync_state callback is called for this device.
 	 */
 	if (dev->fwnode && !dev->fwnode->dev) {
-		dev->fwnode->dev = dev;
+		fw_devlink_set_device(dev->fwnode, dev);
 		fw_devlink_link_device(dev);
 	}
 
@@ -3929,7 +3929,7 @@ void device_del(struct device *dev)
 	device_unlock(dev);
 
 	if (dev->fwnode && dev->fwnode->dev == dev)
-		dev->fwnode->dev = NULL;
+		fw_devlink_set_device(dev->fwnode, NULL);
 
 	/* Notify clients of device removal.  This call must come
 	 * before dpm_sysfs_remove().
-- 
2.55.0

