Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46449176AB5
	for <linux-cxl@vger.kernel.org>; Fri,  7 Feb 2025 23:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738972041; cv=none; b=imWdAHid42gsb2Z9+a+agvgJrd9NQdU7rclJkl7czPuHEMg9w81+vYm4RDtRCZoWTBGSeXXnNwBrNhL17WOe5W74a2HVe3JuasjDHBNgWCMaVLDXe/CQHcWw0T57tV4UHdPAGc0ytHC0CaGpsuxU31KTcaQtaPYvPXWmFs6Vr4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738972041; c=relaxed/simple;
	bh=JkFU/U/1wrMVLGqbh2DU4C9trCOUWZNrzIdfaSW6rXY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UFna/WVGzglMzTTmcC1bG/VrovqVxUSmxYkK0i2C7617WyQNd3kJ2KY3Jae7wnuEbhL9KX5DAaXSevFpn4NayarSx2cgMAvicymWRTtWg0GTLw4uXpD2FG92NFtL6j0gvA258EWN2VYko5HYklcR1D9iVOIcZn7I+gEBnaCgqXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948CAC4CED1;
	Fri,  7 Feb 2025 23:47:20 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: alison.schofield@intel.com
Subject: [NDCTL PATCH v3 0/3] ndctl: Add support and test for CXL Features support
Date: Fri,  7 Feb 2025 16:46:32 -0700
Message-ID: <20250207234718.2387622-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3:
- Update test to use opcode instead of command id.

v2:
- Drop features device enumeration
- Add discovery of char device under memdev

The series provides support of libcxl enumerating FWCTL character device
under the cxl_memdev device. It discovers the char device major
and minor numbers for the CXL features device in order to allow issuing
of ioctls to the device. 

A unit test is added to locate cxl_memdev exported by the cxl_test
kernel module and issue all the supported ioctls to the associated
FWCTL char device to verify that all the ioctl paths are working as expected.

Kernel series: https://lore.kernel.org/linux-cxl/20250207233914.2375110-1-dave.jiang@intel.com/T/#t

Dave Jiang (3):
      cxl: Add cxl_bus_get_by_provider()
      cxl: Enumerate major/minor of FWCTL char device
      cxl/test: Add test for cxl features device

 cxl/lib/libcxl.c     |  85 +++++++++++++++++
 cxl/lib/libcxl.sym   |   7 ++
 cxl/lib/private.h    |   1 +
 cxl/libcxl.h         |   4 +
 test/cxl-features.sh |  19 ++++
 test/fwctl.c         | 364 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 test/meson.build     |  17 ++++
 7 files changed, 497 insertions(+)
