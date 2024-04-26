Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DA93CF58
	for <linux-cxl@vger.kernel.org>; Fri, 26 Apr 2024 22:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714171776; cv=none; b=ZlQlWRVjfhcSbvk9cUe66z6A79Lo7GxEFmLv3TGSpgrPSp3YKwwtuJfg9ZieSRN+WBQd6xxa1Sh7Z8aTik08iQgAirRFoLrTMjJ6JOav2DLMgB/J2xFbQZVzRPGtza0uMsvIbPV1xHM735xlDE07DpURtFOQ0JOuiST9FDtrCyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714171776; c=relaxed/simple;
	bh=SSplyacaw25gp3praa6WeGD9lvrgQBiIxtGjQWHnckg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sukfKBKuujnIHGbPWM3tAUwoSdrpHJYwK0xpmxYGygAjQWdl+D/I1DFf9wikQEoGF3N3Lynh9CHdSYT75RByTXBfflKp+vPR1UYgXofAXX3KpFNGlSsUdjcYHp1j9Tham4f31ucwThWSHucPOxyxCoNSQ87iZv6m58Uk0jORsd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39ADC113CD;
	Fri, 26 Apr 2024 22:49:35 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	rrichter@amd.com
Subject: [PATCH] cxl: Fix cxl_endpoint_get_perf_coordinate() support for RCH
Date: Fri, 26 Apr 2024 15:47:56 -0700
Message-ID: <20240426224913.1027420-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Robert reported the following when booting a CXL host with Restricted CXL
Host (RCH) topology:
 [   39.815379] cxl_acpi ACPI0017:00: not a cxl_port device
 [   39.827123] WARNING: CPU: 46 PID: 1754 at drivers/cxl/core/port.c:592 to_cxl_port+0x56/0x70 [cxl_core]

... plus some related subsequent NULL pointer dereference:

 [   40.718708] BUG: kernel NULL pointer dereference, address: 00000000000002d8

The iterator to walk the PCIe path did not account for RCH topology.
However RCH does not support hotplug and the memory exported by the
Restricted CXL Device (RCD) should be covered by HMAT and therefore no
access_coordinate is needed. Add check to see if the endpoint device is
RCD and skip calculation.

Also add a call to cxl_endpoint_get_perf_coordinates() in cxl_test in order
to exercise the topology iterator. The dev_is_pci() check added is to help
with this test and should be harmless for normal operation.

Reported-by: Robert Richter <rrichter@amd.com>
Closes: https://lore.kernel.org/all/Ziv8GfSMSbvlBB0h@rric.localdomain/
Fixes: 592780b8391f ("cxl: Fix retrieving of access_coordinates in PCIe path")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---

Hi Robert,
Can you please try this patch and see if it addresses the issue you saw
on your RCH platform? Thanks!

 drivers/cxl/core/port.c      | 15 ++++++++++++++-
 tools/testing/cxl/test/cxl.c |  3 +++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 762783bb091a..887ed6e358fb 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2184,6 +2184,7 @@ static bool parent_port_is_cxl_root(struct cxl_port *port)
 int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
 				      struct access_coordinate *coord)
 {
+	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
 	struct access_coordinate c[] = {
 		{
 			.read_bandwidth = UINT_MAX,
@@ -2197,12 +2198,20 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
 	struct cxl_port *iter = port;
 	struct cxl_dport *dport;
 	struct pci_dev *pdev;
+	struct device *dev;
 	unsigned int bw;
 	bool is_cxl_root;
 
 	if (!is_cxl_endpoint(port))
 		return -EINVAL;
 
+	/*
+	 * Skip calculation for RCD. Expectation is HMAT already covers RCD case
+	 * since RCH does not support hotplug.
+	 */
+	if (cxlmd->cxlds->rcd)
+		return 0;
+
 	/*
 	 * Exit the loop when the parent port of the current iter port is cxl
 	 * root. The iterative loop starts at the endpoint and gathers the
@@ -2232,8 +2241,12 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
 		return -EINVAL;
 	cxl_coordinates_combine(c, c, dport->coord);
 
+	dev = port->uport_dev->parent;
+	if (!dev_is_pci(dev))
+		return -ENODEV;
+
 	/* Get the calculated PCI paths bandwidth */
-	pdev = to_pci_dev(port->uport_dev->parent);
+	pdev = to_pci_dev(dev);
 	bw = pcie_bandwidth_available(pdev, NULL, NULL, NULL);
 	if (bw == 0)
 		return -ENXIO;
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 61c69297e797..72e2ce58e1dc 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -1001,6 +1001,7 @@ static void mock_cxl_endpoint_parse_cdat(struct cxl_port *port)
 	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+	struct access_coordinate ep_c[ACCESS_COORDINATE_MAX];
 	struct range pmem_range = {
 		.start = cxlds->pmem_res.start,
 		.end = cxlds->pmem_res.end,
@@ -1020,6 +1021,8 @@ static void mock_cxl_endpoint_parse_cdat(struct cxl_port *port)
 		dpa_perf_setup(port, &pmem_range, &mds->pmem_perf);
 
 	cxl_memdev_update_perf(cxlmd);
+
+	cxl_endpoint_get_perf_coordinates(port, ep_c);
 }
 
 static struct cxl_mock_ops cxl_mock_ops = {
-- 
2.44.0

