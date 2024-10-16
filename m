Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBA2197521
	for <linux-cxl@vger.kernel.org>; Wed, 16 Oct 2024 19:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729105203; cv=none; b=UX8ye2EK84q91Nz8zMK9coL1iIh3ZrMj2fNLhQVmVBiUK+r+a5sQV2X6ayBkdlCXsCjEPoBDAs19O97tgH9FGchfZGRY8lwSUc5+DduxKEMMgz9XG5xpknrQlYL0yBmHANd4MH1YihkEf+bS+LJif3xjLZU8mnYfeCAndWKrNDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729105203; c=relaxed/simple;
	bh=YOj+MkjO1rRDsHX8sGk2TUkP7t8x12jge3JTTBqezok=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SDZZMwe4+hI1UrvQQPwLVtxIDVz58FvSF7A7CeIKKft+4gtvUmBBGOcF853ZvZXWB3GZQbYpiJXIYFZU5VFsL7BT4ezj9ORG1SMatHavsTF9QuuDLuwAZLmx+F9nC9nrUV/o7Vy6vg0H/Wb5sp2Ra72eW1TI4duD7FpjQYV4+qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xKrWaWvx; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xKrWaWvx"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb587d0436so1926611fa.2
        for <linux-cxl@vger.kernel.org>; Wed, 16 Oct 2024 12:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729105200; x=1729710000; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7iz2s1NK93ad7qcG8GbVFGDzL4DLEw2RhvxgQNZMziw=;
        b=xKrWaWvxCCfeOsKhQqpcVtZapAY8lzeKU4/bT4uk7d/QgC2Uc/0uCAeIrm+RSSiRPR
         IZ68mt3PMeDFYRttu4N0ZZryLFp5Fj8gLDP1NF+Mq7c/wJN9xR1TyZ2LZDBGIfuPdBpp
         Bng3bKFuyuhFVcZ/GwvBuSPsAu4wWIEJWiyjTlcvnXgZ+68i+X6VMtvW+jmbW2w2MuXQ
         W0svsZV4meN4kkH5S3zgNlBXcuXiLRMC6Lw9YLJXj9nsO/nEbs0NiY0r5OrggcDUV5jm
         sL4jdoJmf1o1onSB9erC/fTgx1sq5eVviJUuDAJD33657180Z6IZ9xoCYaeHMqmzMsqd
         KtVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729105200; x=1729710000;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7iz2s1NK93ad7qcG8GbVFGDzL4DLEw2RhvxgQNZMziw=;
        b=gOSqMnXM6oDqDrZQbV7WtkD8RJTig5eorRVS7ZtG3Wu4G04ZO8wwIgLvTuK4RabqCP
         hmEAgBxH1oH66Hs+e/1eh0zFqKinck9OadyvG98rxfKSapeozacAH5pIkBwpPJgNqF2N
         DTbijYnfFxWVqn5+1e06q5NDIOl957MCFD89GPN8dmDz5bZQzKiBonJ18aC1sJzJ9TPl
         9bOITjKXqMyMMeQXQUIIv3MTnKUC2znREiPTGFJbiGk3R3soRwn+ZRBjjNpu+ISGSm/r
         DIkxfByt+rgTU3vh35z7PqsaOQHNcdOo/FvjXeJiZAsV/DdqxMiob3bfOoyK57HcO08t
         +r0g==
X-Gm-Message-State: AOJu0YzzSBpYHfglhVWTSSD1LOZl1kVYnpt+8F6M+sa8NNQTNjfA2yxf
	XKA9GChSuLGkfw+WAdasUsF/e0o+NuDdj4PSZ3Ad4PzQ4dygm17cMZqt3Geq2uhdPad8iNxeqyA
	6
X-Google-Smtp-Source: AGHT+IHrh+zwevyTPLBuhfhDpvqFLhnNz2dRXfWBlOe6bpBFI4F4MuRdoP7LS+Gb62St1OaCXceE6w==
X-Received: by 2002:a05:651c:2220:b0:2fa:d4c1:3b71 with SMTP id 38308e7fff4ca-2fb3f1b40a4mr75641211fa.19.1729105200055;
        Wed, 16 Oct 2024 12:00:00 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d7b7150sm1976024a12.84.2024.10.16.11.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 11:59:59 -0700 (PDT)
Date: Wed, 16 Oct 2024 21:59:54 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Li Ming <ming4.li@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [bug report] cxl/port: Use scoped_guard()/guard() to drop
 device_lock() for cxl_port
Message-ID: <2a19289b-0bcf-42c4-82a9-268a922535f2@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Li Ming,

Commit 7f569e917b78 ("cxl/port: Use scoped_guard()/guard() to drop
device_lock() for cxl_port") from Aug 30, 2024 (linux-next), leads to
the following (unpublished) Smatch static checker warning:

	drivers/cxl/core/port.c:1591 add_port_attach_ep()
	warn: re-assigning __cleanup__ ptr 'port'

drivers/cxl/core/port.c
    1542 static int add_port_attach_ep(struct cxl_memdev *cxlmd,
    1543                               struct device *uport_dev,
    1544                               struct device *dport_dev)
    1545 {
    1546         struct device *dparent = grandparent(dport_dev);
    1547         struct cxl_dport *dport, *parent_dport;
    1548         resource_size_t component_reg_phys;
    1549         int rc;
    1550 
    1551         if (!dparent) {
    1552                 /*
    1553                  * The iteration reached the topology root without finding the
    1554                  * CXL-root 'cxl_port' on a previous iteration, fail for now to
    1555                  * be re-probed after platform driver attaches.
    1556                  */
    1557                 dev_dbg(&cxlmd->dev, "%s is a root dport\n",
    1558                         dev_name(dport_dev));
    1559                 return -ENXIO;
    1560         }
    1561 
    1562         struct cxl_port *parent_port __free(put_cxl_port) =
    1563                 find_cxl_port(dparent, &parent_dport);
    1564         if (!parent_port) {
    1565                 /* iterate to create this parent_port */
    1566                 return -EAGAIN;
    1567         }
    1568 
    1569         /*
    1570          * Definition with __free() here to keep the sequence of
    1571          * dereferencing the device of the port before the parent_port releasing.
    1572          */
    1573         struct cxl_port *port __free(put_cxl_port) = NULL;
                                  ^^^^^^^^^^^^^^^^^^^^^^^^
We free port when we exit the function, fine.

    1574         scoped_guard(device, &parent_port->dev) {
    1575                 if (!parent_port->dev.driver) {
    1576                         dev_warn(&cxlmd->dev,
    1577                                  "port %s:%s disabled, failed to enumerate CXL.mem\n",
    1578                                  dev_name(&parent_port->dev), dev_name(uport_dev));
    1579                         return -ENXIO;
    1580                 }
    1581 
    1582                 port = find_cxl_port_at(parent_port, dport_dev, &dport);
    1583                 if (!port) {
    1584                         component_reg_phys = find_component_registers(uport_dev);
    1585                         port = devm_cxl_add_port(&parent_port->dev, uport_dev,
    1586                                                  component_reg_phys, parent_dport);

This port from devm_cxl_add_port() needs to be undone.

    1587                         if (IS_ERR(port))
    1588                                 return PTR_ERR(port);
    1589 
    1590                         /* retry find to pick up the new dport information */
--> 1591                         port = find_cxl_port_at(parent_port, dport_dev, &dport);

But we re-assign port here so it will only free this port and not the one from
devm_cxl_add_port().

    1592                         if (!port)
    1593                                 return -ENXIO;
    1594                 }
    1595         }
    1596 
    1597         dev_dbg(&cxlmd->dev, "add to new port %s:%s\n",
    1598                 dev_name(&port->dev), dev_name(port->uport_dev));
    1599         rc = cxl_add_ep(dport, &cxlmd->dev);
    1600         if (rc == -EBUSY) {
    1601                 /*
    1602                  * "can't" happen, but this error code means
    1603                  * something to the caller, so translate it.
    1604                  */
    1605                 rc = -ENXIO;
    1606         }
    1607 
    1608         return rc;
    1609 }

regards,
dan carpenter
