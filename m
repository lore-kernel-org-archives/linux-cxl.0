Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D24346A10
	for <linux-cxl@vger.kernel.org>; Wed, 10 Jun 2026 22:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781130212; cv=none; b=gCXtDd6524yj+hsOkqRsvJbYZPi7n4KHmfmpn10m0s2uNVZt1yeWQ3tC/77tpN+kMmCclvS8A0Ze8bekWG0AI5/dUFcDHtzhrvUgmteJ89VX98ZkvNmt68bAxKAmSgWi6zqhZmoI8xw9LaGroFZgOwtEUislZyc5OWgpgT+BlnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781130212; c=relaxed/simple;
	bh=vHyqTDYtN2j9Mx8v9aOZJL73mXddbK5Trej5XBqKw4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G5x72qVdQoYctldZruHBntH1KW2R9IMjCb+uvgCMUMshw21c+VzmLcRu+Ezy/kCvmP6hgTQbXeSVj/Q9NKlSBc9h/y7lE7EuWSfrhsL9NUC/tHkztci0h8lnqW7O3IrBOhqnHqvfRHNqYpfEMT2kcTatfbKCgrG8yNobHR62FxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED471F00893;
	Wed, 10 Jun 2026 22:23:31 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: djbw@kernel.org,
	dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com
Subject: [PATCH v3 0/6] cxl: Add CXL type2 accelerator support for cxl_test
Date: Wed, 10 Jun 2026 15:23:22 -0700
Message-ID: <20260610222328.2272427-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

See individual patches for changes from previous version.

The series is based on v7.1-rc7 with Dan's region devm-cxl_probe_mem()
series [1] plus a 0-day fix [2] and Alejandro's type2 series v27 [3].

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

[1]: https://lore.kernel.org/linux-cxl/5f399564-7efe-444d-a6cf-2c6176e57ad9@intel.com/T/#t
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-7.3/cxl-type2-enabling
[3]: https://lore.kernel.org/linux-cxl/20260609215755.8685-1-alejandro.lucero-palau@amd.com/T/#t

Dave Jiang (6):
  cxl/test: Add test for module parameters
  cxl/test: Add type2 support for mock CFMWS0
  cxl/test: Refactor platform device enumerations
  cxl/test: Add hierarchy enumeration support for type2 device
  cxl/test: Fixup hdm init for auto region to support type2
  cxl/test: Add cxl_test accelerator driver

 tools/testing/cxl/test/Kbuild  |   2 +
 tools/testing/cxl/test/accel.c |  66 +++
 tools/testing/cxl/test/cxl.c   | 789 +++++++++++++++++++++++++--------
 3 files changed, 666 insertions(+), 191 deletions(-)
 create mode 100644 tools/testing/cxl/test/accel.c


base-commit: fb6e9f132f0b98c0cf99f8f08ec6ced52139d9b7
-- 
2.54.0

