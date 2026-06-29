Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C8D2C11D9
	for <linux-cxl@vger.kernel.org>; Mon, 29 Jun 2026 22:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782771071; cv=none; b=lTtO0B5e+DITmLJaz3wKIY1g0FaTmIlY1V9z2mEfCGi0lSzhaF1xlD7MNj2rjwQNSLwkY+WLyw7ow/hcdjIg36mz7o8Vlfi+edOkTuB82WkaJ9058epp7pUymM3LqdQ9Fqq0RJmVO31OH7bAkn/uvooxQPrR1sHEsbe40+RroZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782771071; c=relaxed/simple;
	bh=oEnhFjb+vX1mkttfdBznzixu7R/HEc62qTCq2+Ha55U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fikOXqXzlBdP8IggS2I4p3hR/66b1482xwCzCU3GutmhPtQMtfku1BvvsvA9g0X1/qj/F4qBis3aqCjb+7f+k1ldJjSDbcq4CoUiHMLyhd3rk4APBVembpRCBxmYp+eNP2dxyxqTfygsMFsrfgD9sMaT6OX9alJKOLgamuxo1fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CECAB1F000E9;
	Mon, 29 Jun 2026 22:11:09 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: djbw@kernel.org,
	dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com
Subject: [PATCH v7 0/7] cxl: Add CXL type2 accelerator support for cxl_test
Date: Mon, 29 Jun 2026 15:10:57 -0700
Message-ID: <20260629221104.3891733-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v7
- Fixed sachiko raised issues

Based against v7.2-rc1 and sits on top of the the immutable branch [1]
for type 2.

See individual patches for changes from previous version.
Fixed up sashiko reported issues.

Series adds a 'type2_test' module parameter where it setup a mock type2
hierarchy with a mock type2 accelerator device directly under a root
port that has an auto region setup.

It also includes a CXL fix that was encountered when running tests with
the new code.

[
  {
    "memdevs":[
      {
        "memdev":"mem0",
        "ram_size":536870912,
        "ram_qos_class":42,
        "host":"cxl_type2_accel.0",
        "poison_injectable":false
      }
    ]
  },
  {
    "regions":[
      {
        "region":"region0",
        "resource":70300293136384,
        "size":536870912,
        "type":"ram",
        "interleave_ways":1,
        "interleave_granularity":4096,
        "decode_state":"commit"
      }
    ]
  }
]

    "root decoders":[
      {
        "decoder":"decoder0.0",
        "resource":70300293136384,
        "size":1073741824,
        "interleave_ways":1,
        "accelmem_capable":true,
        "qos_class":42,
        "nr_targets":1
      },

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-7.3/cxl-type2-support

Dave Jiang (7):
  cxl/test: Add test for module parameters
  cxl/test: Add type2 support for mock CFMWS0
  cxl/test: Refactor platform device enumerations
  cxl/test: Add hierarchy enumeration support for type2 device
  cxl/test: Propagate -ENOMEM on platform_device_alloc() failures
  cxl/test: Fixup hdm init for auto region to support type2
  cxl/test: Add cxl_test accelerator driver

 tools/testing/cxl/test/Kbuild      |   2 +
 tools/testing/cxl/test/accel.c     |  66 +++
 tools/testing/cxl/test/cxl.c       | 850 ++++++++++++++++++++++-------
 tools/testing/cxl/test/hmem_test.c |   3 +-
 tools/testing/cxl/test/mock.h      |   2 +
 5 files changed, 720 insertions(+), 203 deletions(-)
 create mode 100644 tools/testing/cxl/test/accel.c


base-commit: 96ddf1af34f5f9e29891a5bfb7a18dd0a5bab9d6
-- 
2.54.0

