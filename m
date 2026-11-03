Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793721398;
	b=dy3f5AwJDz1Pkywr1ZmgfcSo3jhd60yWXA1ggMoqMtYc4MmXf67mv0A6hplTM/Mhy+VF
	 4GOlK3mSp1y2AorCAt+Gq69eTiorZffjjeXq7Il6tsdVBYfgPCFRUA3UpVuZn/InFTEsw
	 Rv8csbAuIDamihT8I9sXzdQv1Lu8FTnh7UqF39lWcLBs0kopUGGx6yKWeLSe/Is/FDp+y
	 JjayOBpvyQzVadr7Sx6cjnfCLK0L2zKmqsl82civ+lgEWgT6Wov9OScbtUVG8VW+gtB+3
	 W4CZnXvLmwSti5ncffBvIiZtRlVvjsLcp72b0tS+j3FzdoFKfljLuQT6KQUlHcxi4Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793721398;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=VtbvE/wi+r1db1317acIdezolGI3eGnw0B2xfIHOof4=;
	b=xLXoYvwWyK4b++cd+7iPYPvep+ciiB51jYf/NAqA9A75fUobbgc8sDON8LSKeIEfXSJp
	 xKMuLKmIQeImHkSacW8jKyk9AFC3OWz8xKVgLaS6IKInwOMkZ+bYVzAw/3qt4OpbmBO5G
	 FdCD7K+IrLKB3sCJPwvjMn6wOEfEyO4D5E6BPTSBz7y1ZW1i/0AULTF8zKOD1a+LroeJJ
	 ydAZKpOpv8N2JejPF1r5oOUYne0jTkK98pb+oxItuHiwmI6PTv3+2bekVzii3krrMZ4wp
	 aFdxsHWTgglsqihzIeNWoBDvMZv6oYNcqqnnw0cAjwn8Qu/NEFyyhLJJ6rOlNwbUIGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=WYnMHotI;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0608B606D81F
	for <linux-cxl@vger.kernel.org>; Tue,  3 Nov 2026 15:56:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0608B606D81F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=WYnMHotI
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B62614E413DC;
	Tue,  3 Nov 2026 15:56:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 890D76046C;
	Tue,  3 Nov 2026 15:56:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 739F2103290E8;
	Tue,  3 Nov 2026 16:56:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793721393; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=VtbvE/wi+r1db1317acIdezolGI3eGnw0B2xfIHOof4=;
	b=WYnMHotIpxvyjJRNbVB6F10sQkLBnJohFPlIIBI+z7iRJf0qy22QM3xVJjrfeM8/Aw36bA
	IOwxyiLoSsGxN+p6YP2Upe+ZCiGlrVAPMZwMnAALyqJxpO63qkUpI3xhwUvu8h5gQ8gdO2
	c5uIFgr2WjRGxjmGVF1Cf9T2h1EHy1os/DFEW788CjXn5cR/pn3Gy5JJhVnieZuNL7idvJ
	ADzk6Be/xcZrBxsqaNYKZ9QPUXz5uRW5YV/nwr+AsCvzgzI115r4GTNM2u3C9V+fLO6iDx
	b9i+PP18FCbT1E79Cd5pCnBtL6vo+nbS4xYH9yojvb0aZKag/YcwUiHgjq/+Bg==
From: Herve Codina <herve.codina@bootlin.com>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>,
	Richard Cheng <icheng@nvidia.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
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
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v14 03/10] pinctrl: cs42l43: Use fw_devlink_set_device()
Date: Tue,  3 Nov 2026 16:55:09 +0100
Message-ID: <20261103155540.365294-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103155540.365294-1-herve.codina@bootlin.com>
References: <20261103155540.365294-1-herve.codina@bootlin.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The code set directly fwnode->dev field.

Use the dedicated fw_devlink_set_device() helper to perform this
operation.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Acked-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/pinctrl/cirrus/pinctrl-cs42l43.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/cirrus/pinctrl-cs42l43.c b/drivers/pinctrl/cirrus/pinctrl-cs42l43.c
index 8990fab0446c..563070aba3d8 100644
--- a/drivers/pinctrl/cirrus/pinctrl-cs42l43.c
+++ b/drivers/pinctrl/cirrus/pinctrl-cs42l43.c
@@ -576,7 +576,7 @@ static int cs42l43_pin_probe(struct platform_device *pdev)
 				return ret;
 
 			if (!child->dev)
-				child->dev = priv->dev;
+				fw_devlink_set_device(child, priv->dev);
 			fwnode = child;
 		}
 	}
-- 
2.56.0

