Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F951CAA92
	for <linux-cxl@vger.kernel.org>; Sun, 11 Oct 2026 00:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791678030; cv=none; b=RHhlpZYT7Kc52jB/9n6ntldQSJThV4VrvpbzRwmVYrML3Xm1RHmEhzjQU08vbP9gUvvfNTEkfYzZ1tTbuCaMsCATIUC+9pafwvlivAV+lEu8BmaR1uIXGOyjkTHQpZOu0zWg5vFErgjHfwub1Sot+2r8SMRUDhkxlyY/k2YVqMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791678030; c=relaxed/simple;
	bh=DUOqm+0yVr6GWLq4HMcmJWAvQMy0J12OkBqQ1bpKZlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I8rnjuEKPp+70GY3iZ018ZQJ7Jnv1wo3N4gFTvI9mAG4keAFnQT4Z9xMme/m4BSl5BlamdDGx5wBCyV4EF6GEp0NuyAT8Pb52ObLyWnOpR2jUDwFmzGpn0fyqFuAebcvIVik6Z++fcg1PTVA8KDxZbg+FxQ9GyCu0IrZq0QYdPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QgCrvtXB; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QgCrvtXB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791678029; x=1823214029;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DUOqm+0yVr6GWLq4HMcmJWAvQMy0J12OkBqQ1bpKZlQ=;
  b=QgCrvtXBhudcT7IKpa8Z1Fq4JGRE5rl+Ajb06GkG6e0iL1Bw0VJnUi8a
   qQqYEcbySWpbz+wS9mnee6hoFiFTND9LW23QhtWRLopjP1AjORel8Vln9
   Bx7THAhbKQ693/Bl/o16jiuxyYSnqq0hTyxuQsI4VpA2PGnlQQv8Fd7xR
   GNnEQ8OBrmFWrNcZ+o6U+AWRDEUK/cmiJ5JlPjtambk6HQ6PuKy5pWrfr
   7tnunaq+4+smQOFn6ZfJhnmCUdWBX2eMDOjr9QduJC6tKNVCx6N3VZqGn
   oXJDK9PRumOZcgdeq6PPO+qQHp4aXu4td8HRaG9kTcQjTF57owH2TTz5x
   Q==;
X-CSE-ConnectionGUID: 8GntK3bxSAemsRhnExXL3w==
X-CSE-MsgGUID: r/Ls+kfdQ0azr7ZQYn49Ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11931"; a="459304"
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="459304"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2026 17:20:28 -0700
X-CSE-ConnectionGUID: tcE0rOq2TSqENQ8sUYnXew==
X-CSE-MsgGUID: LCtnGo5YTo+lBAYiC/1u4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="679006"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.8])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2026 17:20:27 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Richard Cheng <icheng@nvidia.com>,
	Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v2 0/8] cxl/region: Refactor cxl_port_setup_targets()
Date: Sat, 10 Oct 2026 17:20:15 -0700
Message-ID: <cover.1791676454.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:
- New patch 3 adds 'switch' to cxl_port_setup_targets() name (DaveJ)
- Add 'switch' to cxl_port_add_target() name (DaveJ)
- Pass the switch decoder to cxl_switch_port_add_target (DaveJ)
- Minor commit message updates based on function renamings
Link to v1: https://lore.kernel.org/linux-cxl/cover.1791575481.git.alison.schofield@intel.com/

Begin Cover Letter:
cxl_port_setup_targets() has grown to nearly 200 lines. It open codes each
step of adding an endpoint to a port's decoder: finding the distance
between peer positions, reading the parent interleave, calculating and
validating the port's interleave, setting up the decoder, and adding the
target.

This set is inspired by review feedback from Robert Richter on the series
that adds mixed-granularity region support [1]. That series needs to change
how this function calculates interleaves and Robert asked for that new code
to be moved into a helper. Rather than tidy only the new code, this set
splits up the whole function first.

Patches 1 and 2 prepare the code that moves. Both patches are suggestions
that Jonathan offered on the mixed gran series, and Patch 2 is actually
plucked from the mixed gran series where it sat as a prep patch.

Patch 3 renames the function to cxl_switch_port_setup_targets(), since it
configures switch decoder targets.

Patches 4-8 each move one step at a time into its own helper, which leaves
cxl_switch_port_setup_targets() at 58 lines.

The refactor patches make no functional changes and aims to be mechanical
and easy to review. I tried to avoid all 'while you're at it' changes
that would muddy the mechanical split.

That base commit is from cxl/next, as of this moment.

[1] https://lore.kernel.org/linux-cxl/cover.1788475206.git.alison.schofield@intel.com/


Alison Schofield (8):
  cxl: Add interleave encoding validity helpers
  cxl/region: Name the interleave locals in cxl_port_setup_targets()
  cxl/region: Rename cxl_port_setup_targets() to
    cxl_switch_port_setup_targets()
  cxl/region: Factor out cxl_port_peer_distance()
  cxl/region: Factor out cxl_port_parent_interleave()
  cxl/region: Factor out cxl_port_calc_interleave()
  cxl/region: Factor out cxl_port_setup_decoder()
  cxl/region: Factor out cxl_switch_port_add_target()

 drivers/cxl/core/region.c | 255 +++++++++++++++++++++++---------------
 drivers/cxl/cxl.h         |  21 ++++
 2 files changed, 178 insertions(+), 98 deletions(-)


base-commit: 71392a644e88c6bb921cdf12cb2b00adec070fe4
-- 
2.37.3

