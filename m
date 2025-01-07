Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7DB2AF10;
	Tue,  7 Jan 2025 03:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736222256; cv=pass; b=hHW9zO3gw3151oFD8wL3Vn1HjzYpWoi4aRU1hULwCmQQKr7D9T7XJTC25vQyI5mVJWpbZvwobOe3Q23V60QwgnFDpKn8jXOheiQZ67t4Px0G9MabMOMYc7coAqxqeA7yJnid6BAG0XlMFEP1kK4mFybRbh/PK7zgDVjPohB7IY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736222256; c=relaxed/simple;
	bh=vHfBce0or100V7vu1/3T4a5d9qILgvUvYgl4Ny+HJXo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U8HnUvVLf6494viEHXXCkfHkwed4Gy89HRlsSv1lNG2LeyoXkPIAVF/SnD/wXRDv8xpKnJrd+7RsowvCI0HdebhzqgbkHkDuwKD0MI5XjdqYQplmRWkDz3sjns5YPY3nZ4oY1j64wovH7MS4Pa3qUsqkkqzVrxUL2eaWvOKBke8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=PyRXc7K+; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="PyRXc7K+"
ARC-Seal: i=1; a=rsa-sha256; t=1736222239; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lfno9F2ET4f6b2XxNPZtW67wvQIWY95pAjyfAwmTLo6fISzPi9RKawl2e4SWu5UsbsiCAs8eMeZy9U0xzhLARsFYwJ3diywhM002HJhHi2GQ9MhxIL729Slb5V6epwyYo4sF0XAb+7LwRgG7kO0x3saDuyfR+8ktHpK+rgBXt2c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1736222239; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0fxGRvNo6qSlmR5wUDNTNE7NOBBzpVNJdnN1I9Qb64U=; 
	b=KalhkZQteGFBbK9sNqH2pUQ+pTcLHV6COqRAeSqLpJeD3in4B5BK7/rviGcznGNBCrSQniexQi1N6rYyPnCOgSmoYBpeLr6+XzW7ODDVO0PBugCl7kyD6r+HtxrhZoQ5NZVl44R0utEvlOiws56xWoEGM1wHqs/bEHQEZs1XKTs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736222239;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=0fxGRvNo6qSlmR5wUDNTNE7NOBBzpVNJdnN1I9Qb64U=;
	b=PyRXc7K+i4xydNDFww3+LVW6odo7vgWPTCDsUxYjQWwGSW7+KLC9Z5cYxFkLOwku
	EobFJrqV2H5MibftpPK9JfVzPwiHkXW+75/OZ2tV9J/e/8yVS/cKB9n1V+TSqfRd/x/
	gfMVWD+JNPix4yvofn8vzvodj55nIEljSK6q0fKY=
Received: by mx.zohomail.com with SMTPS id 1736222238281542.3005677431127;
	Mon, 6 Jan 2025 19:57:18 -0800 (PST)
From: Li Ming <ming.li@zohomail.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Ming <ming.li@zohomail.com>
Subject: [RFC PATCH 0/8] Delay to enumerate ports/dports component registers
Date: Tue,  7 Jan 2025 11:57:00 +0800
Message-Id: <20250107035708.1134954-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227c1c7c858dc417be14dadf31e0000f2dd31117cd81a05eb7137e6a514b6c6cb4819bf094df8c911:zu080112278ab0e5d132cfcc7640b8633a0000b49bb5115a4d415003bdb246a29405899ee7ac519d1cbb1dc5:rf0801122d80cd81a32ea6f48982a8d3fd00002bc0059ccf9b47d91b9bbaa9331e137dca1bea0543544a80894e32684d792f:ZohoMail
X-ZohoMailClient: External

This patchset implements the long term fix for the locating CXL.CM
capability failure issue[1].

In some hardware platform, CXL capable ports and dports will not expose
component registers if they are not working on CXL mode, but CXL
subsystem always enumerates component registers on a CXL port/dport
during it is added to the hierarchy. It causes component registers
enumeration failure on a CXL port or CXL dport if no CXL device is
under it when the CXL port or CXL dport is attaching to the hierarchy.
It will be a problem on the environment with CXL hotplug support.

The solution in this patchset is that moving port and dport component
registers enumeration from devm_cxl_add_port()/devm_cxl_add_dport() into
cxl_endpoint_port_probe(), delaying port and dport component registers
enumeration until the first endpoint port probing. When the first
endpoint port is probing, it represents ancestor ports and dports are
working on CXL mode.

To support this solution, extra changes are needed in this patchset:
1. Ancestor ports' HDM initialization also needs to be moved from
cxl_switch_port_probe() to cxl_endpoint_port_probe(), because HDM
initialization should be done after component registers are ready.

2. Remove ancestor ports' HDM and reset ancestor ports and dports'
component registers information when the last endpoint of the hierarchy
detaching, so that the first endpoint attaching can enumerate ancestor
ports and dports' component registers and set up HDM on ancestor ports
next time.

base-commit: 4bbf9020becbfd8fc2c3da790855b7042fad455b v6.13-rc4 
[1] https://lore.kernel.org/linux-cxl/59EA939D-03E1-40FC-88D2-BCFA4DE5A436@suse.de/


Li Ming (8):
  cxl/port: Enumerate port component regs when endpoint attaching
  cxl/port: Delay port HDM setup until port component regs setup done
  cxl/region: Check if dev is a decoder in check_commit_order()
  cxl/port: Remove port HDM during the last endpoint detaching
  cxl/port: Remove component_reg_phys parameter from devm_cxl_add_port()
  cxl/port: Enumerate dport component registers when endpoint attaching
  cxl/port: Remove component_reg_phys parameter from
    devm_cxl_add_dport()
  cxl/mem: Adjust cxl_dport_init_ras_reporting() invoked position

 drivers/cxl/acpi.c            |   6 +-
 drivers/cxl/core/pci.c        |   8 +-
 drivers/cxl/core/port.c       | 229 +++++++++++++++++++++-------------
 drivers/cxl/core/region.c     |   8 +-
 drivers/cxl/cxl.h             |  10 +-
 drivers/cxl/mem.c             |   7 +-
 drivers/cxl/port.c            |  40 +++++-
 tools/testing/cxl/test/cxl.c  |   4 +-
 tools/testing/cxl/test/mock.c |   3 +-
 9 files changed, 206 insertions(+), 109 deletions(-)

-- 
2.34.1

