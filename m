Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB14E52CCE6
	for <linux-cxl@vger.kernel.org>; Tue, 13 Oct 2026 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791913834; cv=none; b=lfopVHkj9M/m6myC6xSxmaD9wRa5qLu8ci9m/ekDp+I+goLsDmtW1MAv2qvX85TwCaBPR7UnmJm9Gz5UYcVPSoxCO9iXlTowAkWgCjGZl7WUNAez8yrqozBWhC0IT0PuIRCl8TTfNK5CWLjTMxHOMR97mnK/AAvl4cBDw/0BJ7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791913834; c=relaxed/simple;
	bh=Bwpuvl8v0DRrGDDmnSEGPwnGjwFO+duZvJ5OSkkepIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kGyekAK7b199qXiG/4846iAuiNoXGT2N7y+XLFJhwTdoKThmDbFPryrfq2HAYEd6ln8eZ9qMzv2G89ZKFsyLJipL3Fus+YF5iNq7yoUtJ4jyvmdfr/LHV0vn0YD2A7HXb/WS/MLBnVUzXqLBSIX1azCGg8dCAaGYgb42RKVk4Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pJGPvYO4; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fpb1hr7N; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pJGPvYO4";
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fpb1hr7N"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D80E3C653FE
	for <linux-cxl@vger.kernel.org>; Tue, 13 Oct 2026 17:51:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 41A3F60362
	for <linux-cxl@vger.kernel.org>; Tue, 13 Oct 2026 17:50:30 +0000 (UTC)
Received: by mail.galae.net (Postcow, from userid 0)
	id DA7BE11D717E5; Tue, 13 Oct 2026 19:48:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791913830; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=wTOKh4nIHZqwf3cVaUyxYykTracYnxATB6MngAZuVpg=;
	b=pJGPvYO4lRChOTx09PKTORME2LKxXGFHXyLdzZeUxDDyr055iBFpMsuPcBzjVaVB5cGNRc
	2z9yH5PjbP42/dOWlg8nhp1ZADXBSKDzJQCa+xrNHDIAO2yVMRf30UGEqIv/di76IRVGZ/
	enrcDj5JecdBf4byK9wwf7r4hSzIwSMxFYzdYfMN9QaaCAr+CSUr1yq+FgSf6Xtq4mDATQ
	syB8k0y+QhVdQcKNsHtp5G5PwpuExDuxuAKkXj75AfvisUDOBrXAz7iSzR/JPuGFs5O8ee
	591PCIGkEA9VCoK3QO9aCvAEgpFZHgnu3ZxDaTKPdixddQICptbSP+EtWQkZFw==
Authentication-Results: mail.galae.net;
	none
Received: from mail.galae.net ([172.22.1.253])
	by 9e7fea892943 with LMTP
	id GBPVCfbuzGpsHhEAtaWaaQ
	(envelope-from <herve.codina@bootlin.com>)
	for <herve.codina@bootlin.com>; Mon, 12 Oct 2026 16:30:14 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8AD4311D70C51;
	Mon, 12 Oct 2026 16:30:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791815406; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=wTOKh4nIHZqwf3cVaUyxYykTracYnxATB6MngAZuVpg=;
	b=fpb1hr7N5FKf3AOacO3sWQY50VoGoTDhl6XpnKKsP+N1rNJotDlAPkYvS3EojucBZrQl47
	LKo/RdgnHDpPCd61+sArj1yjY1AG5Ga+Qi91iP58KeVsu8hTonC2HIJb7HHEsBUir94q5u
	syxDSRK0G2G1aEDFqq9JS9KpaaRsudPoCtZRGWIMs2FWRAEpMbMIvw8vzOcPpTZ7bmwGHt
	oZCaR1FYf4/HcsY+8c7mrY4at31g372EjjutdfQNHUad60a2K6NB0hZt2s4MmA+CSZ/YIo
	WNWq6sdkOUpTTV05aXt0HUO+PFTQ+STdMpOw0sQWHvFE5FDZJXFIIHG+44p7JA==
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
	stable+noautosel@kernel.org
Subject: [PATCH v13 10/10] PCI: of: Avoid np->data usage for the node changeset
Date: Mon, 12 Oct 2026 16:28:24 +0200
Message-ID: <20261012142826.159178-11-herve.codina@bootlin.com>
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
X-Rspamd-Queue-Id: DA7BE11D717E5
X-Spamd-Result: default: False [2.48 / 30.00];
	BAYES_HAM(-1.52)[85.14%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	DATE_IN_PAST(1.00)[27];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_NO_TLS_LAST(0.10)[];
	BCC(0.00)[];
	FREEMAIL_TO(0.00)[nvidia.com,lunn.ch,kernel.org,linuxfoundation.org,google.com,opensource.cirrus.com,cirrus.com,linux.intel.com,gmail.com,stgolabs.net,intel.com,zohomail.com,bootlin.com,amd.com];
	DKIM_SIGNED(0.00)[bootlin.com:s=dkim];
	MAILCOW_DOMAIN_HEADER_FROM(0.00)[bootlin.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[herve.codina@bootlin.com];
	RCPT_COUNT_TWELVE(0.00)[43];
	PREVIOUSLY_DELIVERED(0.00)[herve.codina@bootlin.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TAGGED_RCPT(0.00)[noautosel];
	NEURAL_HAM(-0.00)[-1.000];
	URIBL_BLOCKED(0.00)[localhost:rdns,localhost:helo,bootlin.com:mid,bootlin.com:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]

of_pci_remove_node() and of_pci_remove_host_bridge_node() check
whether the node is dynamic but not whether it has valid private data.

During the node creation, an OF changeset is used and this changeset is
stored in np->data to be available for removal functions.

If, for instance, a PCI host bridge is created using a device-tree
overlay, the related node will have the dynamic flag set but np->data
will be NULL. This leads to NULL pointer dereferences.

Checking for a non-NULL np->data pointer to determine if the node has
been created by the PCI node creation process is not enough. Indeed,
on some platforms like PowerPC, the OF_RECONFIG_ATTACH_NODE notifier
(e.g., in the pci_dn_reconfig_notifier() function) intercepts node
additions and populates np->data with its own structure, such as a
struct pci_dn. In that case, np->data is not NULL but it is not related
to our changeset stored during the PCI node process creation.

Avoid the usage of np->data to store the changeset used during the PCI
node creation. Store our changeset in a more relevant structure: either
struct pci_dev when the node is created for a PCI device or struct
pci_host_bridge when the node is created for the PCI host bridge.

With that done, no ambiguity remains on removal. Indeed, this changeset,
if non-NULL, is the one used during PCI node creation. Check and use
this changeset on the removal process.

Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
Fixes: 1f340724419e ("PCI: of: Create device tree PCI host bridge node")
Cc: <stable+noautosel@kernel.org> # Issue not triggered but could be a problem
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/pci/of.c    | 32 ++++++++++++++++++++------------
 include/linux/pci.h | 11 +++++++++++
 2 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 0a5797652e18..fbed24a244d0 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -732,15 +732,20 @@ void of_pci_remove_node(struct pci_dev *pdev)
 {
 	struct device_node *np;
 
+	if (!pdev->cset)
+		return;
+
 	np = pci_device_to_OF_node(pdev);
-	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
+	if (!np)
 		return;
 
 	fw_devlink_set_device(&np->fwnode, NULL);
 	device_remove_of_node(&pdev->dev);
-	of_changeset_revert(np->data);
-	of_changeset_destroy(np->data);
+	of_changeset_revert(pdev->cset);
+	of_changeset_destroy(pdev->cset);
 	of_node_put(np);
+	kfree(pdev->cset);
+	pdev->cset = NULL;
 }
 
 void of_pci_make_dev_node(struct pci_dev *pdev)
@@ -800,18 +805,17 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
 	if (ret)
 		goto out_clear_devlink_dev;
 
-	np->data = cset;
-
 	ret = device_add_of_node(&pdev->dev, np);
 	if (ret)
 		goto out_revert_cset;
 
+	pdev->cset = cset;
+
 	kfree(name);
 
 	return;
 
 out_revert_cset:
-	np->data = NULL;
 	of_changeset_revert(cset);
 out_clear_devlink_dev:
 	fw_devlink_set_device(&np->fwnode, NULL);
@@ -828,16 +832,21 @@ void of_pci_remove_host_bridge_node(struct pci_host_bridge *bridge)
 {
 	struct device_node *np;
 
+	if (!bridge->cset)
+		return;
+
 	np = pci_bus_to_OF_node(bridge->bus);
-	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
+	if (!np)
 		return;
 
 	fw_devlink_set_device(&np->fwnode, NULL);
 	device_remove_of_node(&bridge->bus->dev);
 	device_remove_of_node(&bridge->dev);
-	of_changeset_revert(np->data);
-	of_changeset_destroy(np->data);
+	of_changeset_revert(bridge->cset);
+	of_changeset_destroy(bridge->cset);
 	of_node_put(np);
+	kfree(bridge->cset);
+	bridge->cset = NULL;
 }
 
 void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge)
@@ -899,8 +908,6 @@ void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge)
 	if (ret)
 		goto out_clear_devlink_dev;
 
-	np->data = cset;
-
 	/* Add the of_node to host bridge and the root bus */
 	ret = device_add_of_node(&bridge->dev, np);
 	if (ret)
@@ -910,6 +917,8 @@ void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge)
 	if (ret)
 		goto out_remove_bridge_dev_of_node;
 
+	bridge->cset = cset;
+
 	kfree(name);
 
 	return;
@@ -917,7 +926,6 @@ void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge)
 out_remove_bridge_dev_of_node:
 	device_remove_of_node(&bridge->dev);
 out_revert_cset:
-	np->data = NULL;
 	of_changeset_revert(cset);
 out_clear_devlink_dev:
 	fw_devlink_set_device(&np->fwnode, NULL);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d31a8d107b1e..7b0ba9ec7b5c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -339,6 +339,9 @@ struct pcie_link_state;
 struct pci_sriov;
 struct pci_p2pdma;
 struct rcec_ea;
+#ifdef CONFIG_PCI_DYNAMIC_OF_NODES
+struct of_changeset;
+#endif
 
 /* struct pci_dev - describes a PCI device
  *
@@ -598,6 +601,10 @@ struct pci_dev {
 	u8		tph_mode;	/* TPH mode */
 	u8		tph_req_type;	/* TPH requester type */
 #endif
+
+#ifdef CONFIG_PCI_DYNAMIC_OF_NODES
+	struct of_changeset *cset; /* Changeset used for OF node creation */
+#endif
 };
 
 static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
@@ -670,6 +677,10 @@ struct pci_host_bridge {
 	unsigned int	broken_l1ss_resume:1;	/* Resuming from L1SS during
 						   system suspend is broken */
 
+#ifdef CONFIG_PCI_DYNAMIC_OF_NODES
+	struct of_changeset *cset; /* Changeset used for OF node creation */
+#endif
+
 	/* Resource alignment requirements */
 	resource_size_t (*align_resource)(struct pci_dev *dev,
 			const struct resource *res,
-- 
2.55.0

