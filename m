Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B94625
	for <linux-cxl@vger.kernel.org>; Sat,  1 Feb 2025 00:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738370897; cv=none; b=ETG6MijZm5N5NCBrw74Q+2Cr0lIE+Y+QBNXe9XDvJsoPHb7ThD9CmE9KHn05hR8ta8FgtKi6m2uSjgi3gnRzBiT1EMiqcZQZAEjmlqOOaCmzggs0Dr8w20cTpnw66ZHJtYM9SMZm4oubDBeLBEZdpdLffgpD2OEOLdRFb05q2nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738370897; c=relaxed/simple;
	bh=6cWk1pVHvtJ1k6PAM7alhkP5obWTcTvwTzJN+5Kgewc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dq1H3lS59QcjKz8HHBz+VATVxebbqjh62g4FJW7HvtHh1dLSu8lf0fbrz0srWaUnrG8VeSo0W3k82bGnYW/pyfk+Iy3q3sqjrzSQ934qvdSQhrZPbEVH21PGg7ml0xVBcOvIxC2LoB1NlCXU8RzQP7+Bfy0KaGpvcfnwS8D7wn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9006AC4CED1;
	Sat,  1 Feb 2025 00:48:17 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: alison.schofield@intel.com
Subject: [NDCTL PATCH v2 0/3] ndctl: Add support and test for CXL Features support
Date: Fri, 31 Jan 2025 17:47:28 -0700
Message-ID: <20250201004815.474741-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The series provides support of libcxl enumerating FWCTL character device
under the cxl_memdev device. It discovers the char device major
and minor numbers for the CXL features device in order to allow issuing
of ioctls to the device. 

A unit test is added to locate cxl_memdev exported by the cxl_test
kernel module and issue all the supported ioctls to the associated
FWCTL char device to verify that all the ioctl paths are working as expected.

Kernel series: https://lore.kernel.org/linux-cxl/20250201004459.466499-1-dave.jiang@intel.com/T/#t

Dave Jiang (3):
      cxl: Add cxl_bus_get_by_provider()
      cxl: Enumerate major/minor of FWCTL char device
      cxl/test: Add test for cxl features device

 cxl/lib/libcxl.c     |  85 +++++++++++++++++
 cxl/lib/libcxl.sym   |   7 ++
 cxl/lib/private.h    |   1 +
 cxl/libcxl.h         |   4 +
 test/cxl-features.sh |  19 ++++
 test/fwctl.c         | 360 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 test/meson.build     |  17 ++++
 7 files changed, 493 insertions(+)

