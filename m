Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59121E231F
	for <linux-cxl@vger.kernel.org>; Tue, 11 Feb 2025 18:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739298552; cv=none; b=vDLCJoknL1mkXqW3gte0k0c2hJuuwQsvMRZIE1EfPYnaf7CdSC8q11atQwMTHgl9oiF6CereSwIRMR3/Z7AKNPr6G2ccaF8qMlnDUVs7vFdoICS+hVE50VObD4D0nhDWcMJhW4ppmGwmavknuhnhEtWuoYniMyhF2KU2zeCMQtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739298552; c=relaxed/simple;
	bh=EqjD4rTmIxUkZ4sG2ozcudaDPEqVq2WSNU5pWjtk2hw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lww2AsLjtonoywjhelpnrNqW4Bncyyoqw1qV1Z5UHPnkaA91tZw4UpV7Fz5t7FAvJXK89ztwbzgy2g+s8Gso8uskphkHRCdwDXMAyM9Hoj7UWWg2eRMrEli6tlktPYlo0RJba1UYI02iPEK9ZeYDgb1t21zlKJwZYnudqNf75B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40FEDC4CEDD;
	Tue, 11 Feb 2025 18:29:12 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net,
	jgg@nvidia.com,
	shiju.jose@huawei.com
Subject: [PATCH v5 00/15] cxl: Add CXL feature commands support via fwctl
Date: Tue, 11 Feb 2025 11:27:54 -0700
Message-ID: <20250211182909.1650096-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v5:
- Add devm action to fwctl. (Dan)
- Fix return of NULL instead of ERR_PTR() for get features. (Ming)
- Make cxl_get/set_feature() internal to cxl/core (Dan)
- Add missing NULL check for cxl_set_feature() (Dan)
- Remove cxlmd back pointer from fwctl. (Dan)
- Add missing CONFIG_FWCTL dependency to Kconfig.
- Fix index of for loop for fwctl get features. (Ming)
- See individual patches for detailed changes from v4.

v4:
- Rebase to FWCTL series v4 based on v6.14-rc1
- Merge patch 1/16 from v3 into cxl/next ahead. (Jonathan)
- Move everything to core/features.c and behind CONFIG_CXL_FEATURES. (Dan)
- Split the registration of features into 2 parts. Do the registration in
  PCI probe. One before memdev enumeration to enable kernel feature support,
  and one after memdev enumeration to support FWCTL. (Dan)
- Fix incrememt of pointer after copying feature data. (Ming)
- Add check for no immediate change effect and no reset change effects. (Dan, Jonathan)
- Remove IDs and use opcodes directly. (Dan)
- See individual patches for detailed changes from v3.

v3:
- Rearrange code and shift code forward to reduce diffs. (Jonathan)
- Use struct_size() in appropriate locations. (Jonathan)
- Remove usage of __weak and refactor accordingly. (Jason)
- Return NULL for allocation functions. (Jonathan)
- See individual patches for detailed changes from v2.

v2:
- Drop features device and driver. Move features enabling to cxl_memdev. (Dan)
- Drop sysfs attribute of number of features. (Dan)
- Drop moving of include/uapi/linux/cxl_mem.h. (Dan)
- Set get driver info ioctl to return reserved 32bit. Set behavior of issue
  ioctl successful as indicating Feature commands supported.
- Set 'Set Feature Size' to 0 for kernel exclusive Features.
- See individual patches for detailed changes from v1.
- Hide FWCTL bits behind CONFIG_CXL_FWCTL. (Dan)

v1:
- Create a CXL features driver to handle all feature command related bits
  including FWCTL support. (Dan)
- Tested against CXL CLI unit tests for FWCTL.
- See individual patches for detailed changes from RFC v2.

RFC v2:
- Dropped 1/13 and 2/13 from previous version. Merged upstream already.
- Combined changes from Shiju for "get supported features"
- Addressed comments from Jonathan and Jason
- See specific changes in individual patch revision history
- Added hardware command info to FWCTL
- Added filtering to set feature command
- Added documentation

This series add support for CXL feature commands using the FWCTL framework [1].
The code has been tested with CXL CLI unit tests for FWCTL.

Patches 1-6 are shared with EDAC series [1] and there will be an immutable branch
once accepted post review.

CXL Features support is added behind the CXL mem driver. The 3 mailbox commands
"Get Supported Features", "Get Feature", and "Set Feature" are implemented. The
"Get" commands are under the FWCTL_RPC_CONFIGURATION policy, the "Set" command
checks the policy depending on the set effects of the feature defined by the
device via the Feature set effects field. All mailbox commands for CXL provides
an effects table that describes the effects of a command when performed on the
device.  For CXL features, there is also an effects field that describes the
effects a feature set operation has on the device per feature. The security
policy is checked against this feature specific effects field. 

The code is based off of v4 of FWCTL series [2] posted by Jason and rebased on top of
v6.14-rc1 plus 1 patch in
cxl/next 43ca2463df9d ("cxl: Refactor user ioctl command path from mds to mailbox").
A kernel branch [3] is provided for convience of testing and review.

[1]: https://lore.kernel.org/linux-cxl/20250106121017.1620-1-shiju.jose@huawei.com/T/#t
[2]: https://lore.kernel.org/linux-cxl/0-v3-960f17f90f17+516-fwctl_jgg@nvidia.com/#r
[3]: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/log/?h=cxl/fwctl

---

Dave Jiang (13):
      cxl: Enumerate feature commands
      cxl: Add Get Supported Features command for kernel usage
      cxl/test: Add Get Supported Features mailbox command support
      cxl: Setup exclusive CXL features that are reserved for the kernel
      cxl: Add FWCTL support to CXL
      cxl: Add support for FWCTL get driver information callback
      cxl: Move cxl feature command structs to user header
      cxl: Add support for fwctl RPC command to enable CXL feature commands
      cxl: Add support to handle user feature commands for get feature
      cxl: Add support to handle user feature commands for set feature
      cxl/test: Add Get Feature support to cxl_test
      cxl/test: Add Set Feature support to cxl_test
      fwctl/cxl: Add documentation to FWCTL CXL

Shiju Jose (2):
      cxl/mbox: Add GET_FEATURE mailbox command
      cxl/mbox: Add SET_FEATURE mailbox command

 Documentation/userspace-api/fwctl/fwctl-cxl.rst | 137 ++++++++
 Documentation/userspace-api/fwctl/index.rst     |   1 +
 MAINTAINERS                                     |   1 +
 drivers/cxl/Kconfig                             |  12 +
 drivers/cxl/core/Makefile                       |   1 +
 drivers/cxl/core/core.h                         |  10 +
 drivers/cxl/core/features.c                     | 740 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/mbox.c                         |  36 ++-
 drivers/cxl/cxlmem.h                            |   7 +
 drivers/cxl/pci.c                               |   8 +
 include/cxl/features.h                          |  92 ++++++
 include/cxl/mailbox.h                           |   4 +
 include/uapi/cxl/features.h                     | 128 ++++++++
 include/uapi/fwctl/cxl.h                        |  48 +++
 include/uapi/fwctl/fwctl.h                      |   1 +
 tools/testing/cxl/Kbuild                        |   1 +
 tools/testing/cxl/test/mem.c                    | 184 +++++++++++
 17 files changed, 1410 insertions(+), 1 deletion(-)
