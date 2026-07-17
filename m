Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF138430CD7;
	Fri, 17 Jul 2026 14:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784300005; cv=none; b=e+3GZCJ4Af/tg0lcLwDXK+xNfez/37bXgtFr4A31kY3YgTFDKiRkoZPbAFcWjT3OeWasszCaezu49O7kTrG7gP4HMxdztjeZsWQhWW3mA0HHI/820azq9Bb6mhTZyUtuu9C/tq5IUYFoGY+mCIMrrliOSrH1l98BlWeROWdMDbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784300005; c=relaxed/simple;
	bh=V7UJIhHONa6PwjxaQPM/lB8FRDMH/CPmUpkAoTsUR5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s/b6x8JsrTsoQWDjvWXf1tNDTCtFzwjQzIRR7RcHKak3qHTVzIwtm3qKrd6/rpDPiFRomnrEM/VHEaDjri0+d4uUKZrXx444EZOU+T75hgTa1MSSY6PwoZLjd7R3BLXgK78xfMKsQWTAbHweWpBvd93M3UKChqXcdMdZiLugKzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gv+t3KpE; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gv+t3KpE"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C5F8A1A1065;
	Fri, 17 Jul 2026 14:53:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 96C7160361;
	Fri, 17 Jul 2026 14:53:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 473B111BD02F3;
	Fri, 17 Jul 2026 16:53:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784299991; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=+9CnYiJau8FhyP1JC2OGvkUSIj/sOWL5/3RPGsZv/CE=;
	b=gv+t3KpEI3R2Gs7Gk0luJ0opt4BhYBTkL7kim/VBsj7uOll+ubo8E0dPcSpJtpB2IQjfdx
	hZgDnu+SWi9bSSs7iIvpEb8oQ8DEagzQr8eunj2e8YkjSf1RFswKUW4/Px2drur/G2Bh9W
	p4ouBo8tHFH/QsMpNqGPkGz4kjQHIziiTSHxaUpxjUzQMWZnVFFIITEhLvVvJuOb2tpTEO
	bSBBcJFzouSbB7M8SxOvO/PDpzrk3JT7lhHHi+jV5TZmGlsmUNqJ2Rz8dMTLyG1kK1YyLv
	IsnIoDIWD9Oq3P9OCz40KC2avX+Sk/7FiACrFZjMxrQ2JrL976sK5SqZ9Mn/AQ==
From: Herve Codina <herve.codina@bootlin.com>
To: Richard Cheng <icheng@nvidia.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Linus Walleij <linusw@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Lizhi Hou <lizhi.hou@amd.com>,
	Herve Codina <herve.codina@bootlin.com>
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
	stable+noautosel@kernel.org
Subject: [PATCH v10 10/10] PCI: of: Guard against node removal with incorrect np->data
Date: Fri, 17 Jul 2026 16:51:45 +0200
Message-ID: <20260717145147.823749-11-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260717145147.823749-1-herve.codina@bootlin.com>
References: <20260717145147.823749-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

of_pci_remove_node() and of_pci_remove_host_bridge_node() check
whether the node is dynamic but not whether it has valid private data.

During the node creation, an OF changeset is used and this changeset is
stored in np->data to be available for removal functions.

If, for instance, a PCI host bridge is created using a device-tree
overlay, the related node will have the dynamic flag set but np->data
will be NULL. This leads to NULL pointer dereferences.

Further more, having a NULL np->data pointer means that the node has
been created out of our PCI node creation process and so shouldn't be
handled by our PCI node removal process.

Add a np->data check for NULL to bail out early of PCI node removal
functions.

Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
Fixes: 1f340724419e ("PCI: of: Create device tree PCI host bridge node")
Cc: <stable+noautosel@kernel.org> # Not triggered but 'This could be a problem...'
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/pci/of.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 28896f748e8d..9f35e1e07cdc 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -654,7 +654,7 @@ void of_pci_remove_node(struct pci_dev *pdev)
 	struct device_node *np;
 
 	np = pci_device_to_OF_node(pdev);
-	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
+	if (!np || !of_node_check_flag(np, OF_DYNAMIC) || !np->data)
 		return;
 
 	fw_devlink_set_device(&np->fwnode, NULL);
@@ -750,7 +750,7 @@ void of_pci_remove_host_bridge_node(struct pci_host_bridge *bridge)
 	struct device_node *np;
 
 	np = pci_bus_to_OF_node(bridge->bus);
-	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
+	if (!np || !of_node_check_flag(np, OF_DYNAMIC) || !np->data)
 		return;
 
 	fw_devlink_set_device(&np->fwnode, NULL);
-- 
2.55.0

