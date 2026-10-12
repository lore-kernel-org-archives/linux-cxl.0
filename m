Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FC13B3C05;
	Mon, 12 Oct 2026 13:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791812325; cv=none; b=kqxix6D8gUhDP5LaM4b0NnQmMqE8wK9Epw4V4eqATsIGkv0g4gFyQzc8tYXNqt6f7ocmC4/gPrKvfivP726hlv/RgfCX8x/sMHmcsu1lYiQk6n+lKxVERBlB6ugzsPgc1VbtwZQ8lkjowteNjKz8g7S6dAqm7w/n4jkaOOgHk04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791812325; c=relaxed/simple;
	bh=dEptTwNX9Sq3lL7fDHLWKReZfufeO69vQyYwqPmjcPs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TL/gXxKq5pOEH6kB1/f4JJSSnAA0iDBbTbywYueYTvKjwknEK6fPi1KxBBvquhtCEUYmH8HFHTZHVUgzmBjxf0QOWPTtoFyImTZflPm4xeEc7ur3Z6nyGNRY3Xf1OqE2dhL3pw1aB2UuRG6Q7r+FRmRSWX+YHryj/6IigX6eoCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=P2oKD/iu; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="P2oKD/iu"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4AF1F4E41203;
	Mon, 12 Oct 2026 13:38:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 15458601A6;
	Mon, 12 Oct 2026 13:38:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6D22611D70B5E;
	Mon, 12 Oct 2026 15:38:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791812308; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=kSIOvrEHM3a5XmLq4o4Vz8QQhg7cfJBqO8WQZOEPSfo=;
	b=P2oKD/iuYLKPKxVYgo/dXPzK7+3qO4HQVVCArAfXy2xfTIIGffN6Fz+//KdG8xo1hHy/N0
	6hZ5EDXqnUQIGoGdQsdjAdoTJGgeeftYKc3CSnMnPeUqF6CUYL8cNy5VQ+0a17A8yiZXXV
	s8bkbQwSZEC6UknOCygjtOUU771kiei44of8lPuAHohnuzWe+SoNo9JqYZjpSpIYd8dxPr
	yaBTD2/kVXCXFaLlbCCv/eEZi1SFlxCDHKRNp2ax5v5kByo9s61c8u9fExUmGYUWkESU2B
	vtBm3N6rv+3fUXsb5M4Q/x6D756ZiWWywR1bwuxC7b5+VIMx+dpl6AqCsJBG1g==
Date: Mon, 12 Oct 2026 15:38:11 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Richard Cheng <icheng@nvidia.com>, Andrew Lunn <andrew@lunn.ch>, Rob
 Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Charles Keepax <ckeepax@opensource.cirrus.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>, David Rhodes
 <david.rhodes@cirrus.com>, Linus Walleij <linusw@kernel.org>, Daniel Scally
 <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Bartosz Golaszewski
 <brgl@kernel.org>, Len Brown <lenb@kernel.org>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>, Dave Jiang
 <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Lizhi Hou
 <lizhi.hou@amd.com>, driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-sound@vger.kernel.org, patches@opensource.cirrus.com,
 linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-cxl@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 stable+noautosel@kernel.org
Subject: Re: [PATCH v12 10/10] PCI: of: Avoid np->data usage for the node
 changeset
Message-ID: <20261012153811.2cdcaf89@bootlin.com>
In-Reply-To: <ar62bJzBEAhGL2iu@ashevche-desk.local>
References: <20261001142815.277550-1-herve.codina@bootlin.com>
	<20261001142815.277550-11-herve.codina@bootlin.com>
	<ar62bJzBEAhGL2iu@ashevche-desk.local>
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

Hi Andy,

On Thu, 1 Oct 2026 22:37:16 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Thu, Oct 01, 2026 at 04:28:10PM +0200, Herve Codina wrote:
> > of_pci_remove_node() and of_pci_remove_host_bridge_node() check
> > whether the node is dynamic but not whether it has valid private data.
> > 
> > During the node creation, an OF changeset is used and this changeset is
> > stored in np->data to be available for removal functions.
> > 
> > If, for instance, a PCI host bridge is created using a device-tree
> > overlay, the related node will have the dynamic flag set but np->data
> > will be NULL. This leads to NULL pointer dereferences.
> > 
> > Checking for a non-NULL np->data pointer to determine if the node has
> > been created by the PCI node creation process is not enough. Indeed,
> > on some platforms like PowerPC, the OF_RECONFIG_ATTACH_NODE notifier
> > (e.g., in the pci_dn_reconfig_notifier() function) intercepts node
> > additions and populates np->data with its own structure, such as a
> > struct pci_dn. In that case, np->data is not NULL but it is not related
> > to our changeset stored during the PCI node process creation.
> > 
> > Avoid the usage of np->data to store the changeset used during the PCI
> > node creation. Store our changeset in a more relevant structure: either
> > struct pci_dev when the node is created for a PCI device or struct
> > pci_host_bridge when the node is created for the PCI host bridge.
> > 
> > With that done, no ambiguity remains on removal. Indeed, this changeset,
> > if non-NULL, is the one used during PCI node creation. Check and use
> > this changeset on the removal process.  
> 
> ...
> 
> >  void of_pci_remove_node(struct pci_dev *pdev)  
> 
> >  	struct device_node *np;
> >  
> >  	np = pci_device_to_OF_node(pdev);
> > -	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
> > +	if (!pdev->cset || !np)
> >  		return;  
> 
> Wouldn't be better to split this conditional to two?
> 
> 	if (!pdev->cset)
> 		return;
> 
> 	np = pci_device_to_OF_node(pdev);
> 	if (!np)
> 		return;

Yes indeed, this will improve readability. I will update in the next
iteration.

Also I will perform the same kind of modification in
of_pci_remove_host_bridge_node(), the same kind of check is present.

Best regards,
Hervé
