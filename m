Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF7147C11B;
	Wed,  9 Sep 2026 09:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788945193; cv=none; b=sXNzF90jcK8wtyNL3quH3o4JmgFFZveUvMoq36v9cl0suXsDIQy0bYdv3S50FJuOL3W8ZkLp1KEU01KarYgvemVdrJAvJEwqSeDDqw7e+8wzdg3bt61rHqXKbio2yEup2hEi4HwWQtA5xo1l25ZgFKDAcrql6fWMR6xQe5IHc50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788945193; c=relaxed/simple;
	bh=9FW2UTOgqCav1VjSAAUtH3W+CbF5wggrb4OPxT9/SnU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QUACEWvguOUDgdehPOw3vQV3aOAy+3A/PYuEN6UIoWvwylHAzpU39YdphCsQJTKFeXT3QQOt8V8sH/nvkEbylAUTCMbBw8kUxLRmZhFe2RTRWsOVnbCK0E9T/48H/5N4pJpaEetXIq2Ri1FFnwqsdLq0CWqhJ+V2qpBr26wshrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=G14bceSe; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="G14bceSe"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0CD411A1A7B;
	Wed,  9 Sep 2026 09:13:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CB06E60448;
	Wed,  9 Sep 2026 09:13:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E49CF11C7AF50;
	Wed,  9 Sep 2026 11:12:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788945186; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=9X5Hg2F0uLuCJm6N2AouKct+zmRjRP/xwCe08E1h2Dc=;
	b=G14bceSeMMscqNQfsMmZnO4qhbNFOzGXWjAY9otn4UPr+p2vnmRbPx8NCgh+97c0a8XvK0
	Bt7VHMfcxro5bPWJ9cYVZt2xh6bA9yqB8pePmoWCpCsFrZYTE8UQ39XbqHX00R5uUkOgSf
	T2SHnj47S7r4SfrB5thKh0NYRTIAG3F1dzI6wYA8AEk8aBwHpoj0c9CYEmfUVt6SnH2q1o
	e+OhQ7Hd+w7YpZvTaqaSqTGQHgEI+us9G7dPUfrhjpsgwNFQZcIYD4bOKN0vfUGzLknDrb
	O08QK4OgzsL0A74SZ49trK7KZ8CH5uIBvpcFFNdtVDjjbDGbZocRX+uo5wgw4g==
Date: Wed, 9 Sep 2026 11:12:50 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Richard Cheng <icheng@nvidia.com>, Andrew Lunn <andrew@lunn.ch>, Rob
 Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Charles Keepax <ckeepax@opensource.cirrus.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>, David Rhodes
 <david.rhodes@cirrus.com>, Linus Walleij <linusw@kernel.org>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally
 <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Bartosz Golaszewski
 <brgl@kernel.org>, Len Brown <lenb@kernel.org>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>, Dave Jiang
 <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Herve Codina
 <herve.codina@bootlin.com>, Lizhi Hou <lizhi.hou@amd.com>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-sound@vger.kernel.org,
 patches@opensource.cirrus.com, linux-gpio@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org, Allan Nielsen
 <allan.nielsen@microchip.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 stable+noautosel@kernel.org
Subject: Re: [PATCH v11 10/10] PCI: of: Avoid np->data usage for the node
 changeset
Message-ID: <20260909111250.6b36af7e@bootlin.com>
In-Reply-To: <20260909080114.591938-11-herve.codina@bootlin.com>
References: <20260909080114.591938-1-herve.codina@bootlin.com>
	<20260909080114.591938-11-herve.codina@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi All,

On Wed,  9 Sep 2026 10:01:09 +0200
Herve Codina <herve.codina@bootlin.com> wrote:

> of_pci_remove_node() and of_pci_remove_host_bridge_node() check
> whether the node is dynamic but not whether it has valid private data.
> 
> During the node creation, an OF changeset is used and this changeset is
> stored in np->data to be available for removal functions.
> 
> If, for instance, a PCI host bridge is created using a device-tree
> overlay, the related node will have the dynamic flag set but np->data
> will be NULL. This leads to NULL pointer dereferences.
> 
> Checking for a non-NULL np->data pointer to determine if the node has
> been created by the PCI node creation process is not enough. Indeed,
> on some platforms like PowerPC, the OF_RECONFIG_ATTACH_NODE notifier
> (e.g., in the pci_dn_reconfig_notifier() function) intercepts node
> additions and populates np->data with its own structure, such as a
> struct pci_dn. In that case, np->data is not NULL but it is not related
> to our changeset stored during the PCI node process creation.
> 
> Avoid the usage of np->data to store the changeset used during the PCI
> node creation. Store our changeset in a more relevant structure: either
> struct pci_dev when the node is created for a PCI device or struct
> pci_host_bridge when the node is created for the PCI host bridge.
> 
> With that done, no ambiguity remains on removal. Indeed, this changeset,
> if non-NULL, is the one used during PCI node creation. Check and use
> this changeset on the removal process.
> 
> Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
> Fixes: 1f340724419e ("PCI: of: Create device tree PCI host bridge node")
> Cc: <stable+noautosel@kernel.org> # Issue not triggered but could be a problem
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  drivers/pci/of.c    | 28 ++++++++++++++--------------
>  include/linux/pci.h | 11 +++++++++++
>  2 files changed, 25 insertions(+), 14 deletions(-)
> 

Shashiko has reported issues [0].

IMO, those issues cannot be triggered but I would like to know the opinion of
other people and Maintainers.

Of course, I can update the code to more defensive but is it really needed?

Let me know if I need to send a new iteration with the update (check for a
null np and set cset to NULL after the kfree() call in remove functions).

[0] https://lore.kernel.org/all/20260909110623.2e6bbc89@bootlin.com/

Best regards,
Hervé
