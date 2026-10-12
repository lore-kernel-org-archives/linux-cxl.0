Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A3C3E49DA;
	Mon, 12 Oct 2026 14:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815338; cv=none; b=XE0Euz5UWNdHMD5U1+xvdFpD47jb3tgFPg3IkpFSbgr04mgfUxl7vR6WWMjWwyhIiI3L+UMlbpoNTxK/Zl7MhkfMK6lK+mepMeZzQD8PbKT254oUUWfe5D1VUYZktEnATDRhzoVKYPVyiw/p05mYYJfQQqwe4KBbuLwba7waSeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815338; c=relaxed/simple;
	bh=coh97i91GMzxgaGzGrlbpw70oGHkJw68wM+Zt07XG1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b5KAJgxspY9BhnH/1V5EP8A+LnC52yt4KA/iJF2qzflPUMcfHrGOAVrglAGsjhajxSvza4TwJutzgaITmZ0p4zP16oaXJutiPfpysnronL6DtQZ7fyeNz1fpynVYFYOIgcxisaQfNQb9yqULmNrEbsIVgz4H3nXeYwAMnt20O0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Wkzof3rD; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Wkzof3rD"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B4B174E411A5;
	Mon, 12 Oct 2026 14:28:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7F930601A6;
	Mon, 12 Oct 2026 14:28:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E780111D70508;
	Mon, 12 Oct 2026 16:28:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791815330; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=wUOs5uXVmY1mRqqy3/QemKBbWww+Uoitwg1gZJXQ6Tg=;
	b=Wkzof3rD5kKIsOEnRGDp7BVqKeR2NLQY2ze9BkjKCjB5QmBIA++Z9+Y6MhDw8UAa35Svg5
	7Ukcj+YB9/Qpx93I4NVY6Lm+YpRxajp1iVVOLDfgmdrwy2SX2D0UuNP+BBo84Yu36ngRYo
	lZohkHjBtsxFR1rmVtCl+jhIGH9Z3PqPSyeAMdBja3kfu8lEvSnTgyevgnY+yHVEUwrGtJ
	CsgPL9tpndp1sOi4EgOyif9Bs2F2VkeprFPZ4X8bAP28Zz4fWnWgWbBYcfwNxKn3OBdai/
	7KhMuBb7CqhWVMStvYFupmc3rDQYDoX7D0uVfzCk65jFcbDVngqIf6eiJDpuvg==
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
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v13 00/10] lan966x pci device: Add support for SFPs, PCI part
Date: Mon, 12 Oct 2026 16:28:14 +0200
Message-ID: <20261012142826.159178-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

Previously, I sent a big picture series adding support for SFP ports
available on the LAN966x PCI device [0].

In this series patches touch several parts and sub-system in the kernel.
Reviews have be done and it makes sense to split the series and send
parts separately.

This current series is the extraction of patches related to issues in
the PCI subsystem. It has to be seen as a continuation of the big
picture series but related to this specific core part.

Patches 1 to 6 introduce and use fw_devlink_set_device() in already
existing code. No functional change but the introduction of the
fw_devlink_set_device() wrapper.

Patch 7 avoids a dangling pointer.

Patches 8 and 9 fix fw_devlink issues specific to PCI and the
device-tree nodes created during enumeration.

Patch 10 avoids the usage of np->data and adds guards to prevent
incorrect nodes removal.

[0] https://lore.kernel.org/all/20260325143555.451852-1-herve.codina@bootlin.com/

Best regards,
Hervé

Changes:

v12 -> v13
  v12: https://lore.kernel.org/all/20261001142815.277550-1-herve.codina@bootlin.com/

  - Patches 1 to 9
    No changes

  - Patch 10
    Split a test condition into two distinct checks as suggested by
    Andy. No functional change but readability improvement. Split done
    in both of_pci_remove_node() and of_pci_remove_host_bridge_node().

v11 -> v12
  v11: https://lore.kernel.org/all/20260909080114.591938-1-herve.codina@bootlin.com/

  - Patches 1 to 7
    Add 'Reviewed-by: Bartosz Golaszewski'

  - Patches 8 and 9
    No changes

  - Patch 10
    Add a NULL check for the retrieved OF node in removal functions to
    avoid any NULL pointer dereferences.
    Robustify the guard setting cset to NULL after freeing it.
    Those issues have been reported by Shashiko:
    https://lore.kernel.org/all/20260909081755.444E91F00A3A@smtp.kernel.org/

v10 -> v11
  v10: https://lore.kernel.org/all/20260717145147.823749-1-herve.codina@bootlin.com/

  Rebase on top of v7.3-rc1

  - Patches 1 to 5
    Add 'Reviewed-by: Richard Cheng'

  - Patches 6, 7 and 8
    Add 'Reviewed-by: Richard Cheng'
    Add 'Acked-by: Manivannan Sadhasivam'

  - Patch 9
    Add 'Reviewed-by: Richard Cheng'

  - Patch 10
    Rework removing np->data usage in the PCI devicetree node creation
    and removal.

v9 -> v10
  v9: https://lore.kernel.org/all/20260708100302.517792-1-herve.codina@bootlin.com/

  - Patches 1 to 6
    No changes

  - Patch 7
    Clear fwnode->dev also on error path.

  - Patch 8
    Clear fwnode->dev also on error path.

  - Patch 9
    No changes

  - Patch 10 (New patch in v10)
    Guard against node removal with incorrect np->data.

v8 -> v9
  v8: https://lore.kernel.org/all/20260630102804.413563-1-herve.codina@bootlin.com/

  - Patch 7 (new patch in v9)
    Clear fwnode->dev during root bridge node removal (avoid a dangling
    pointer).

  - Patch 8 (patch 7 in v8)
    Clear fwnode->dev during PCI device node removal.

v7 -> v8
  v7: https://lore.kernel.org/all/20260511155930.34604-1-herve.codina@bootlin.com/

  Rebase on top of v7.2-rc1

  - patches 4 and 5
    Add 'Reviewed-by: Andy Shevchenko'

  - Other Patches
    No other changes

v6 -> v7

  Rebase on top of v7.1-rc1

  - Patch 1
     Add Cc stable. Needed for patches 11 and 12

  - Patches 2 to 5
    No changes

  - Patch 6
     Add Cc stable. Needed for patch 13
     Add 'Acked-by: Bjorn Helgaas'

  - Patch 7
     Fix a typo in commit log
     Add Fixes tag + Cc stable
     Add 'Acked-by: Bjorn Helgaas'

  - Patch 8
     Add Fixes tag + Cc stable
     Add 'Acked-by: Bjorn Helgaas'
Older iterations:
  Patches 6 to 13 in the big picture series
  https://lore.kernel.org/all/20260325143555.451852-1-herve.codina@bootlin.com/

Herve Codina (10):
  driver core: fw_devlink: Introduce fw_devlink_set_device()
  drivers: core: Use fw_devlink_set_device()
  pinctrl: cs42l43: Use fw_devlink_set_device()
  cxl/test: Use device_set_node()
  cxl/test: Use fw_devlink_set_device()
  PCI: of: Use fw_devlink_set_device()
  PCI: of: Clear fwnode->dev during root bridge node removal and error
    path
  PCI: of: Set fwnode device of newly created PCI device nodes
  PCI: of: Remove fwnode_dev_initialized() call for a PCI root bridge
    node
  PCI: of: Avoid np->data usage for the node changeset

 drivers/base/core.c                      |  4 +-
 drivers/pci/of.c                         | 52 ++++++++++++++++--------
 drivers/pinctrl/cirrus/pinctrl-cs42l43.c |  2 +-
 include/linux/fwnode.h                   |  6 +++
 include/linux/pci.h                      | 11 +++++
 tools/testing/cxl/test/cxl.c             |  4 +-
 6 files changed, 58 insertions(+), 21 deletions(-)

-- 
2.55.0

