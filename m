Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8532AB39
	for <linux-cxl@vger.kernel.org>; Thu, 12 Oct 2023 18:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CmAWvJcZ"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0187E83
	for <linux-cxl@vger.kernel.org>; Thu, 12 Oct 2023 11:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697136888; x=1728672888;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8hxjDmVX1OydIcenRR9z10bTX4lDKT4LHWmEbjr1YBQ=;
  b=CmAWvJcZ0dxuOvhMR69XsBeW5pwDKEXgYByGqHtH1qUHmfCEq9ZUtay8
   dxNjfPRwf7e3Zq5EHVqiuDbL3WcaJZJ6ZJxanXAbhFY7UjEOzCeVpNR6z
   aC4/yMmSZ6DTKDKAB6haZ3zXy9YQqApLB04yz17XgmCNFWYCL5EK4TcKD
   zuP8ENYAHhVmpy5jSnEsORfbENiS8yO0T+bGvDSdYCgprOvmon4rXcbkl
   cw4b1jjKbXMgKdgbwdC7ePWqm7oyl7ooytXFzjnseaKMKn/LjcgFNLefl
   3Vr9H9WyyTUSb39OviP4aRSoUkSnPJ4MtoCVNXP8Y93w54UWNJ8V7cYcG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="388880216"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="388880216"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 11:54:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="870711192"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="870711192"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.15.16])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 11:54:32 -0700
Subject: [PATCH v11 10/22] acpi: numa: Add setting of generic port system
 locality attributes
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Thu, 12 Oct 2023 11:54:31 -0700
Message-ID: <169713687154.2205276.17278968721451562796.stgit@djiang5-mobl3>
In-Reply-To: <169713674328.2205276.10184241477215488339.stgit@djiang5-mobl3>
References: <169713674328.2205276.10184241477215488339.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add generic port support for the parsing of HMAT system locality sub-table.
The attributes will be added to the third array member of the access
coordinates in order to not mix with the existing memory attributes. It only
provides the system locality attributes from initator to the generic port
targets and is missing the rest of the data to the actual memory device.

The complete attributes will be updated when a memory device is
attached and the system locality information is calculated end to end.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/numa/hmat.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 957a38137c7e..aabd89c79e26 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -60,6 +60,7 @@ struct target_cache {
 enum {
 	NODE_ACCESS_CLASS_0 = 0,
 	NODE_ACCESS_CLASS_1,
+	NODE_ACCESS_CLASS_GENPORT_SINK,
 	NODE_ACCESS_CLASS_MAX,
 };
 
@@ -336,6 +337,10 @@ static __init void hmat_update_target(unsigned int tgt_pxm, unsigned int init_px
 		if (node_state(pxm_to_node(init_pxm), N_CPU))
 			hmat_update_target_access(target, type, value,
 						  NODE_ACCESS_CLASS_1);
+		/* Update access from generic port target */
+		if (*target->gen_port_device_handle)
+			hmat_update_target_access(target, type, value,
+						  NODE_ACCESS_CLASS_GENPORT_SINK);
 	}
 }
 


