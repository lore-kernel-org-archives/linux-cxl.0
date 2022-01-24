Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8651C433F5
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jan 2022 00:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240634AbiAXAxA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 23 Jan 2022 19:53:00 -0500
Received: from mga12.intel.com ([192.55.52.136]:42135 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240656AbiAXAw6 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sun, 23 Jan 2022 19:52:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642985578; x=1674521578;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zq2WaiqzPKS/ifBe6Ehti+Vw/s2fGHi8GnHTYg+ORg8=;
  b=SlTGK7NDgiPe6pN0OlAVqRWDMtgQYS9hqXCZCNhvyv6Bc9QuyIWqk4sY
   OG4nE8KsjpPdXBFIg1v3NF5Y6zdUkCjHPd7ejvf95k8+OoOofVFkdjldY
   DqkD8JNX0aVYlR8qMVUqRltt4zxfkPgVoN4eUtoRgmCD7J7gll4kGeOim
   mptBKgVsAXhX6g8hPoHRrtKR8MMm6M9bBYEmNK0fl+WciMunKl2fIiCLB
   7r6vyo6FcaS6wUD2RuCgimS30aR6lSl/TsLMOlK77t65P+AiYYE61GdjN
   0DChSb5l1hwEka+0o3XUp68K2jUNT0f9GOd6AqDW8Mply24J4hsrr6zEt
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="225916668"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208,217";a="225916668"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:52:57 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208,217";a="695243370"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:52:57 -0800
Subject: [ndctl PATCH 13/37] Documentation: Enhance libcxl memdev API
 documentation
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     vishal.l.verma@intel.com
Date:   Sun, 23 Jan 2022 16:52:57 -0800
Message-ID: <164298557771.3021641.14904324834528700206.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In preparation for adding documentation for more objects, organize the
current into subsections and flesh out descriptions for the current APIs.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/copyright.txt      |    2 -
 Documentation/cxl/lib/libcxl.txt |  111 ++++++++++++++++++++++++++++++++++----
 2 files changed, 99 insertions(+), 14 deletions(-)

diff --git a/Documentation/copyright.txt b/Documentation/copyright.txt
index a9380e199750..af9caf7ba22a 100644
--- a/Documentation/copyright.txt
+++ b/Documentation/copyright.txt
@@ -2,7 +2,7 @@
 
 COPYRIGHT
 ---------
-Copyright (C) 2016 - 2020, Intel Corporation. License GPLv2: GNU GPL
+Copyright (C) 2016 - 2022, Intel Corporation. License GPLv2: GNU GPL
 version 2 <http://gnu.org/licenses/gpl.html>.  This is free software:
 you are free to change and redistribute it.  There is NO WARRANTY, to
 the extent permitted by law.
diff --git a/Documentation/cxl/lib/libcxl.txt b/Documentation/cxl/lib/libcxl.txt
index 2539369e8111..c127326a2840 100644
--- a/Documentation/cxl/lib/libcxl.txt
+++ b/Documentation/cxl/lib/libcxl.txt
@@ -20,27 +20,100 @@ libcxl provides interfaces to interact with CXL devices in Linux, using sysfs
 interfaces for most kernel interactions, and the ioctl() interface for command
 submission.
 
-The starting point for all library interfaces is a 'cxl_ctx' object, returned
-by linklibcxl:cxl_new[3]. CXL 'Type 3' memory devices are children of the
-cxl_ctx object, and can be iterated through using an iterator API.
+The starting point for all library interfaces is a 'cxl_ctx' object,
+returned by linklibcxl:cxl_new[3]. CXL 'Type 3' memory devices and other
+CXL device objects are descendants of the cxl_ctx object, and can be
+iterated via an object an iterator API of the form
+cxl_<object>_foreach(<parent object>, <object iterator>).
 
-Library level interfaces that are agnostic to any device, or a specific
-subclass of operations have the prefix 'cxl_'
+MEMDEVS
+-------
+The object representing a CXL memory expander (Type 3 device) is 'struct
+cxl_memdev'. Library interfaces related to these devices have the prefix
+'cxl_memdev_'. These interfaces are mostly associated with sysfs
+interactions (unless otherwise noted in their respective documentation
+sections). They are typically used to retrieve data published by the
+kernel, or to send data or trigger kernel operations for a given device.
 
-The object representing a CXL Type 3 device is 'cxl_memdev'. Library interfaces
-related to these devices have the prefix 'cxl_memdev_'. These interfaces are
-mostly associated with sysfs interactions (unless otherwise noted in their
-respective documentation pages). They are typically used to retrieve data
-published by the kernel, or to send data or trigger kernel operations for a
-given device.
+=== MEMDEV: Enumeration
+----
+struct cxl_memdev *cxl_memdev_get_first(struct cxl_ctx *ctx);
+struct cxl_memdev *cxl_memdev_get_next(struct cxl_memdev *memdev);
+struct cxl_ctx *cxl_memdev_get_ctx(struct cxl_memdev *memdev);
+
+#define cxl_memdev_foreach(ctx, memdev) \
+        for (memdev = cxl_memdev_get_first(ctx); \
+             memdev != NULL; \
+             memdev = cxl_memdev_get_next(memdev))
+
+----
+
+CXL memdev instances are enumerated from the global library context
+'struct cxl_ctx'. By default a memdev only offers a portal to submit
+memory device commands, see the port, decoder, and endpoint APIs to
+determine what if any CXL Memory Resources are reachable given a
+specific memdev.
+
+=== MEMDEV: Attributes
+----
+int cxl_memdev_get_id(struct cxl_memdev *memdev);
+unsigned long long cxl_memdev_get_serial(struct cxl_memdev *memdev);
+const char *cxl_memdev_get_devname(struct cxl_memdev *memdev);
+int cxl_memdev_get_major(struct cxl_memdev *memdev);
+int cxl_memdev_get_minor(struct cxl_memdev *memdev);
+unsigned long long cxl_memdev_get_pmem_size(struct cxl_memdev *memdev);
+unsigned long long cxl_memdev_get_ram_size(struct cxl_memdev *memdev);
+const char *cxl_memdev_get_firmware_verison(struct cxl_memdev *memdev);
+size_t cxl_memdev_get_label_size(struct cxl_memdev *memdev);
+int cxl_memdev_nvdimm_bridge_active(struct cxl_memdev *memdev);
+----
+
+A memdev is given a kernel device name of the form "mem%d" where an id
+(cxl_memdev_get_id()) is dynamically allocated as devices are
+discovered. Note that there are no guarantees that ids / kernel device
+names for memdevs are stable from one boot to the next, devices are
+enumerated asynchronously. If a stable identifier is use
+cxl_memdev_get_serial() which returns a value according to the 'Device
+Serial Number Extended Capability' in the PCIe 5.0 Base Specification.
+
+The character device node for command submission can be found by default
+at /dev/cxl/mem%d, or created with a major / minor returned from
+cxl_memdev_get_{major,minor}().
+
+The 'pmem_size' and 'ram_size' attributes return the current
+provisioning of DPA (Device Physical Address / local capacity) in the
+device.
+
+=== MEMDEV: Commands
+----
+struct cxl_cmd *cxl_cmd_new_raw(struct cxl_memdev *memdev, int opcode);
+struct cxl_cmd *cxl_cmd_new_identify(struct cxl_memdev *memdev);
+struct cxl_cmd *cxl_cmd_new_get_health_info(struct cxl_memdev *memdev);
+struct cxl_cmd *cxl_cmd_new_read_label(struct cxl_memdev *memdev,
+					unsigned int offset, unsigned int length);
+struct cxl_cmd *cxl_cmd_new_write_label(struct cxl_memdev *memdev, void *buf,
+					unsigned int offset, unsigned int length);
+int cxl_memdev_zero_label(struct cxl_memdev *memdev, size_t length,
+			  size_t offset);
+int cxl_memdev_read_label(struct cxl_memdev *memdev, void *buf, size_t length,
+			  size_t offset);
+int cxl_memdev_write_label(struct cxl_memdev *memdev, void *buf, size_t length,
+			   size_t offset);
+
+----
 
 A 'cxl_cmd' is a reference counted object which is used to perform 'Mailbox'
 commands as described in the CXL Specification. A 'cxl_cmd' object is tied to a
 'cxl_memdev'. Associated library interfaces have the prefix 'cxl_cmd_'. Within
 this sub-class of interfaces, there are:
 
- * 'cxl_cmd_new_*' interfaces that allocate a new cxl_cmd object for a given
-   command type.
+ * 'cxl_cmd_new_*()' interfaces that allocate a new cxl_cmd object for a given
+   command type targeted at a given memdev. As part of the command
+   instantiation process the library validates that the command is
+   supported by the memory device, otherwise it returns NULL to indicate
+   'no support'. The libcxl command id is translated by the kernel into
+   a CXL standard opcode. See the potential command ids in
+   /usr/include/linux/cxl_mem.h.
 
  * 'cxl_cmd_submit' which submits the command via ioctl()
 
@@ -49,6 +122,18 @@ this sub-class of interfaces, there are:
 
  * 'cxl_cmd_get_*' interfaces to get general command related information.
 
+cxl_cmd_new_raw() supports so called 'RAW' commands where the command id
+is 'RAW' and it carries an unmodified CXL memory device command payload
+associated with the 'opcode' argument. Given the kernel does minimal
+input validation on these commands typically raw commands are not
+supported by the kernel outside debug build scenarios. libcxl is limited
+to supporting commands that appear in the CXL standard / public
+specifications.
+
+cxl_memdev{read,write,zero}_label() are helpers for marshaling multiple
+label access commands over an arbitrary extent of the device's label
+area.
+
 include::../../copyright.txt[]
 
 SEE ALSO

