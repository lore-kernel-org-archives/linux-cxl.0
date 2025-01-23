Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD81E1D555
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 00:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737591787; cv=none; b=H7dQNKEF6zvsWwP/DkJ/5z/XldSgXrXN1bD293NtUVwZUSN1IuX+7X/b8f1jb15gWqnfLtJlCW4CIwDWkTji4syWXg3Z6hVyuhY87EkbFOOpkwKOyzGkITfW/d/pN75kGVMJZRJ/BsQhr9MqxxMBvyR2l3sq4KlCtJeordDVTsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737591787; c=relaxed/simple;
	bh=6IUMae4X4AvM/iphrM+zUrIrRlgr6jrV3Mc8mWgI3GY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lRmvf6ZteAzPGXbjSZiKXKrGhkzJq/dV5lLa/pK3RR3Tk2gmiz3OXcA8ggXnJgz3URsuFZ6f5WwvCAaV5keWfOevmLSzAEXRGcG8Tn9sxO0T4UL47hUXXnn+Kyk+N0LGQIs0EbFXyOUBgyYJ/pDJbu3QycUNKz4NIG6iCFA7iWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE7CC4CED2;
	Thu, 23 Jan 2025 00:23:06 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: alison.schofield@intel.com
Subject: [NDCTL PATCH 0/5] ndctl: Add support and test for CXL features driver 
Date: Wed, 22 Jan 2025 17:21:59 -0700
Message-ID: <20250123002304.2758417-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The series provides support of libcxl enumerating the 'features' device
exported by the CXL kernel driver. It discovers the char device major
and minor numbers for the CXL features device in order to allow issuing
of ioctls to the device. libcxl will also associate the 'features' device
with an 'endpoint' port device in order to allow finding the appropriate
char dev from the endpoint device. It feels appropriate to associate
with the endpoint device rather than the memdev since the features device
comes out of the mailbox of a CLX device that may or may not be a memdev.

A unit test is added to locate a feature device exported by the cxl_test
kernel module and issue all the supported ioctls to verify that all the
ioctl paths are working as expected.

Dave Jiang (5):
      cxl: Add cxl_bus_get_by_provider()
      cxl: Enumerate features 'devices'
      cxl: Add get major and minor for cxl features device
      cxl: Associate CXL features device with CXL endpoint
      cxl/test: Add test for cxl features device

 cxl/lib/libcxl.c     | 308 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 cxl/lib/libcxl.sym   |  13 +++
 cxl/lib/private.h    |  16 ++++
 cxl/libcxl.h         |  17 ++++
 test/cxl-features.sh |  17 ++++
 test/fwctl.c         | 362 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 test/meson.build     |  16 ++++
 7 files changed, 749 insertions(+)

