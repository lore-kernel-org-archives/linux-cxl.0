Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F32241682
	for <linux-cxl@vger.kernel.org>; Mon, 23 Jun 2025 10:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750672837; cv=none; b=bzGpk9NwrGXny8a889IQqaLjb8+fQBJzjSFJYlPieRUxz6dMzdzvHZbbI0vst9aPOyj9gmu1KvYZxYWyecZwfKS5MEt0VozVX7UgoPrwLvqpn8cIy6IjAVOQlWLOkn6UdsLkfabLoI81sK78bo1uqFUiVNgn+Ym2xw5lcIwTVjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750672837; c=relaxed/simple;
	bh=zlA09CkuzwuxG1/Gu9Ktwimz0F8ULxZBegIPH75q2G4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=graisA8PM0E1v0WpcHPyLCtDx+bj7HFSYCX3k5+DOMuNr3MlybbXiB5tMF+Rpj8qNtNIcriE4QLxceeLV9ApH2mqCdFJY60yjGjjOWKPdKu9J9yM5S633bPbqXJPXaK/JIj3SqInuZHIBaZguUmXyt4MImNVxaqkI7uWM4Jl1aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kjlUyxJS; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kjlUyxJS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750672835; x=1782208835;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zlA09CkuzwuxG1/Gu9Ktwimz0F8ULxZBegIPH75q2G4=;
  b=kjlUyxJSM16VQ/Kypp0RwHOuGVZZVWIF20MGRy0HHr3zpnRJaThvCP0h
   EPs2ASJ9xqaRwas2euhGYKMpfxpRz8Zn+a1yJQO6GDdmup0NPlAkfg+Hy
   51I4iDLIQa3SKqEJazW0Sux9XFxg2NvYHBY6Rub3jG0g2c7hyqxaK9+U8
   zUWMmAA7EWP2eE4N/VFEgPR2JHjoqmU7nzjmuQDgzOcSlKOS9Wp52F46P
   Or9smUcq2urPgvVgPsfW/xC48NxH25AC1Hr+dPyU88YZ9oJTHHSLHYN0q
   dQhG8Vxo3iUnj/df1e6h4s2E3CpYSESrwTbXKrGXxO1DJ4V9/5y3bP2kf
   A==;
X-CSE-ConnectionGUID: pyeEQdyWQS6qT8bIPXSVog==
X-CSE-MsgGUID: 35X4e4yfSeKOsCK0Xz5x3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="64227958"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="64227958"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 03:00:34 -0700
X-CSE-ConnectionGUID: WcSJC7DXSzWzJpCzC+jkWQ==
X-CSE-MsgGUID: ecUkFxIJTY2WhQf9vy2dkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="151023820"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 23 Jun 2025 03:00:32 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uTdyX-000NvY-0u;
	Mon, 23 Jun 2025 10:00:29 +0000
Date: Mon, 23 Jun 2025 18:00:05 +0800
From: kernel test robot <lkp@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:for-6.17/cxl-acquire 1/8]
 kernel/trace/trace_events_synth.c:1295:12: warning: stack frame size (1040)
 exceeds limit (1024) in '__create_synth_event'
Message-ID: <202506231745.lcWYDSWD-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-6.17/cxl-acquire
head:   6c90a41a7833a6bb2fb17b9f3cafda66ebdf259b
commit: 41e8737fed161ee0cfc9692d8eff881440ef4b10 [1/8] cleanup: Introduce ACQUIRE() and ACQUIRE_ERR() for conditional locks
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20250623/202506231745.lcWYDSWD-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250623/202506231745.lcWYDSWD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506231745.lcWYDSWD-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/trace/trace_events_synth.c:1295:12: warning: stack frame size (1040) exceeds limit (1024) in '__create_synth_event' [-Wframe-larger-than]
   static int __create_synth_event(const char *name, const char *raw_fields)
              ^
   461/1040 (44.33%) spills, 579/1040 (55.67%) variables
   1 warning generated.


vim +/__create_synth_event +1295 kernel/trace/trace_events_synth.c

726721a51838e3 Tom Zanussi             2020-05-28  1294  
c9e759b1e8456a Tom Zanussi             2021-02-01 @1295  static int __create_synth_event(const char *name, const char *raw_fields)
726721a51838e3 Tom Zanussi             2020-05-28  1296  {
c9e759b1e8456a Tom Zanussi             2021-02-01  1297  	char **argv, *field_str, *tmp_fields, *saved_fields = NULL;
726721a51838e3 Tom Zanussi             2020-05-28  1298  	struct synth_field *field, *fields[SYNTH_FIELDS_MAX];
8b5ab6bd0b2934 Tom Zanussi             2021-02-01  1299  	int consumed, cmd_version = 1, n_fields_this_loop;
c9e759b1e8456a Tom Zanussi             2021-02-01  1300  	int i, argc, n_fields = 0, ret = 0;
726721a51838e3 Tom Zanussi             2020-05-28  1301  	struct synth_event *event = NULL;
d4d704637d935e Tom Zanussi             2020-10-13  1302  
726721a51838e3 Tom Zanussi             2020-05-28  1303  	/*
726721a51838e3 Tom Zanussi             2020-05-28  1304  	 * Argument syntax:
726721a51838e3 Tom Zanussi             2020-05-28  1305  	 *  - Add synthetic event: <event_name> field[;field] ...
726721a51838e3 Tom Zanussi             2020-05-28  1306  	 *  - Remove synthetic event: !<event_name> field[;field] ...
726721a51838e3 Tom Zanussi             2020-05-28  1307  	 *      where 'field' = type field_name
726721a51838e3 Tom Zanussi             2020-05-28  1308  	 */
726721a51838e3 Tom Zanussi             2020-05-28  1309  
c9e759b1e8456a Tom Zanussi             2021-02-01  1310  	if (name[0] == '\0') {
8d3e8165232322 Tom Zanussi             2021-02-01  1311  		synth_err(SYNTH_ERR_INVALID_CMD, 0);
726721a51838e3 Tom Zanussi             2020-05-28  1312  		return -EINVAL;
d4d704637d935e Tom Zanussi             2020-10-13  1313  	}
726721a51838e3 Tom Zanussi             2020-05-28  1314  
9bbb33291f8e44 Tom Zanussi             2020-10-13  1315  	if (!is_good_name(name)) {
d4d704637d935e Tom Zanussi             2020-10-13  1316  		synth_err(SYNTH_ERR_BAD_NAME, errpos(name));
c9e759b1e8456a Tom Zanussi             2021-02-01  1317  		return -EINVAL;
9bbb33291f8e44 Tom Zanussi             2020-10-13  1318  	}
9bbb33291f8e44 Tom Zanussi             2020-10-13  1319  
c9e759b1e8456a Tom Zanussi             2021-02-01  1320  	mutex_lock(&event_mutex);
c9e759b1e8456a Tom Zanussi             2021-02-01  1321  
726721a51838e3 Tom Zanussi             2020-05-28  1322  	event = find_synth_event(name);
726721a51838e3 Tom Zanussi             2020-05-28  1323  	if (event) {
d4d704637d935e Tom Zanussi             2020-10-13  1324  		synth_err(SYNTH_ERR_EVENT_EXISTS, errpos(name));
726721a51838e3 Tom Zanussi             2020-05-28  1325  		ret = -EEXIST;
c9e759b1e8456a Tom Zanussi             2021-02-01  1326  		goto err;
726721a51838e3 Tom Zanussi             2020-05-28  1327  	}
726721a51838e3 Tom Zanussi             2020-05-28  1328  
c9e759b1e8456a Tom Zanussi             2021-02-01  1329  	tmp_fields = saved_fields = kstrdup(raw_fields, GFP_KERNEL);
c9e759b1e8456a Tom Zanussi             2021-02-01  1330  	if (!tmp_fields) {
c9e759b1e8456a Tom Zanussi             2021-02-01  1331  		ret = -ENOMEM;
c9e759b1e8456a Tom Zanussi             2021-02-01  1332  		goto err;
c9e759b1e8456a Tom Zanussi             2021-02-01  1333  	}
c9e759b1e8456a Tom Zanussi             2021-02-01  1334  
c9e759b1e8456a Tom Zanussi             2021-02-01  1335  	while ((field_str = strsep(&tmp_fields, ";")) != NULL) {
c9e759b1e8456a Tom Zanussi             2021-02-01  1336  		argv = argv_split(GFP_KERNEL, field_str, &argc);
c9e759b1e8456a Tom Zanussi             2021-02-01  1337  		if (!argv) {
c9e759b1e8456a Tom Zanussi             2021-02-01  1338  			ret = -ENOMEM;
726721a51838e3 Tom Zanussi             2020-05-28  1339  			goto err;
726721a51838e3 Tom Zanussi             2020-05-28  1340  		}
726721a51838e3 Tom Zanussi             2020-05-28  1341  
f40fc799afc598 Vamshi K Sthambamkadi   2021-03-04  1342  		if (!argc) {
f40fc799afc598 Vamshi K Sthambamkadi   2021-03-04  1343  			argv_free(argv);
c9e759b1e8456a Tom Zanussi             2021-02-01  1344  			continue;
f40fc799afc598 Vamshi K Sthambamkadi   2021-03-04  1345  		}
c9e759b1e8456a Tom Zanussi             2021-02-01  1346  
8b5ab6bd0b2934 Tom Zanussi             2021-02-01  1347  		n_fields_this_loop = 0;
8b5ab6bd0b2934 Tom Zanussi             2021-02-01  1348  		consumed = 0;
8b5ab6bd0b2934 Tom Zanussi             2021-02-01  1349  		while (argc > consumed) {
8b5ab6bd0b2934 Tom Zanussi             2021-02-01  1350  			int field_version;
8b5ab6bd0b2934 Tom Zanussi             2021-02-01  1351  
8b5ab6bd0b2934 Tom Zanussi             2021-02-01  1352  			field = parse_synth_field(argc - consumed,
8b5ab6bd0b2934 Tom Zanussi             2021-02-01  1353  						  argv + consumed, &consumed,
8b5ab6bd0b2934 Tom Zanussi             2021-02-01  1354  						  &field_version);
726721a51838e3 Tom Zanussi             2020-05-28  1355  			if (IS_ERR(field)) {
726721a51838e3 Tom Zanussi             2020-05-28  1356  				ret = PTR_ERR(field);
c24be24aed405d Miaoqian Lin            2021-12-09  1357  				goto err_free_arg;
726721a51838e3 Tom Zanussi             2020-05-28  1358  			}
c9e759b1e8456a Tom Zanussi             2021-02-01  1359  
8b5ab6bd0b2934 Tom Zanussi             2021-02-01  1360  			/*
8b5ab6bd0b2934 Tom Zanussi             2021-02-01  1361  			 * Track the highest version of any field we
8b5ab6bd0b2934 Tom Zanussi             2021-02-01  1362  			 * found in the command.
8b5ab6bd0b2934 Tom Zanussi             2021-02-01  1363  			 */
8b5ab6bd0b2934 Tom Zanussi             2021-02-01  1364  			if (field_version > cmd_version)
8b5ab6bd0b2934 Tom Zanussi             2021-02-01  1365  				cmd_version = field_version;
8b5ab6bd0b2934 Tom Zanussi             2021-02-01  1366  
8b5ab6bd0b2934 Tom Zanussi             2021-02-01  1367  			/*
8b5ab6bd0b2934 Tom Zanussi             2021-02-01  1368  			 * Now sort out what is and isn't valid for
8b5ab6bd0b2934 Tom Zanussi             2021-02-01  1369  			 * each supported version.
8b5ab6bd0b2934 Tom Zanussi             2021-02-01  1370  			 *
8b5ab6bd0b2934 Tom Zanussi             2021-02-01  1371  			 * If we see more than 1 field per loop, it
8b5ab6bd0b2934 Tom Zanussi             2021-02-01  1372  			 * means we have multiple fields between
8b5ab6bd0b2934 Tom Zanussi             2021-02-01  1373  			 * semicolons, and that's something we no
8b5ab6bd0b2934 Tom Zanussi             2021-02-01  1374  			 * longer support in a version 2 or greater
8b5ab6bd0b2934 Tom Zanussi             2021-02-01  1375  			 * command.
8b5ab6bd0b2934 Tom Zanussi             2021-02-01  1376  			 */
8b5ab6bd0b2934 Tom Zanussi             2021-02-01  1377  			if (cmd_version > 1 && n_fields_this_loop >= 1) {
8b5ab6bd0b2934 Tom Zanussi             2021-02-01  1378  				synth_err(SYNTH_ERR_INVALID_CMD, errpos(field_str));
8b5ab6bd0b2934 Tom Zanussi             2021-02-01  1379  				ret = -EINVAL;
c24be24aed405d Miaoqian Lin            2021-12-09  1380  				goto err_free_arg;
8b5ab6bd0b2934 Tom Zanussi             2021-02-01  1381  			}
c9e759b1e8456a Tom Zanussi             2021-02-01  1382  
c9e759b1e8456a Tom Zanussi             2021-02-01  1383  			if (n_fields == SYNTH_FIELDS_MAX) {
c9e759b1e8456a Tom Zanussi             2021-02-01  1384  				synth_err(SYNTH_ERR_TOO_MANY_FIELDS, 0);
c9e759b1e8456a Tom Zanussi             2021-02-01  1385  				ret = -EINVAL;
c24be24aed405d Miaoqian Lin            2021-12-09  1386  				goto err_free_arg;
c9e759b1e8456a Tom Zanussi             2021-02-01  1387  			}
ff4837f7fe59ff Zheng Yejian            2022-12-07  1388  			fields[n_fields++] = field;
8b5ab6bd0b2934 Tom Zanussi             2021-02-01  1389  
8b5ab6bd0b2934 Tom Zanussi             2021-02-01  1390  			n_fields_this_loop++;
8b5ab6bd0b2934 Tom Zanussi             2021-02-01  1391  		}
c24be24aed405d Miaoqian Lin            2021-12-09  1392  		argv_free(argv);
8b5ab6bd0b2934 Tom Zanussi             2021-02-01  1393  
8b5ab6bd0b2934 Tom Zanussi             2021-02-01  1394  		if (consumed < argc) {
8b5ab6bd0b2934 Tom Zanussi             2021-02-01  1395  			synth_err(SYNTH_ERR_INVALID_CMD, 0);
8b5ab6bd0b2934 Tom Zanussi             2021-02-01  1396  			ret = -EINVAL;
8b5ab6bd0b2934 Tom Zanussi             2021-02-01  1397  			goto err;
8b5ab6bd0b2934 Tom Zanussi             2021-02-01  1398  		}
8b5ab6bd0b2934 Tom Zanussi             2021-02-01  1399  
726721a51838e3 Tom Zanussi             2020-05-28  1400  	}
726721a51838e3 Tom Zanussi             2020-05-28  1401  
c9e759b1e8456a Tom Zanussi             2021-02-01  1402  	if (n_fields == 0) {
8d3e8165232322 Tom Zanussi             2021-02-01  1403  		synth_err(SYNTH_ERR_INVALID_CMD, 0);
726721a51838e3 Tom Zanussi             2020-05-28  1404  		ret = -EINVAL;
726721a51838e3 Tom Zanussi             2020-05-28  1405  		goto err;
726721a51838e3 Tom Zanussi             2020-05-28  1406  	}
726721a51838e3 Tom Zanussi             2020-05-28  1407  
726721a51838e3 Tom Zanussi             2020-05-28  1408  	event = alloc_synth_event(name, n_fields, fields);
726721a51838e3 Tom Zanussi             2020-05-28  1409  	if (IS_ERR(event)) {
726721a51838e3 Tom Zanussi             2020-05-28  1410  		ret = PTR_ERR(event);
726721a51838e3 Tom Zanussi             2020-05-28  1411  		event = NULL;
726721a51838e3 Tom Zanussi             2020-05-28  1412  		goto err;
726721a51838e3 Tom Zanussi             2020-05-28  1413  	}
726721a51838e3 Tom Zanussi             2020-05-28  1414  	ret = register_synth_event(event);
726721a51838e3 Tom Zanussi             2020-05-28  1415  	if (!ret)
8b0e6c744fef64 Steven Rostedt (VMware  2021-08-16  1416) 		dyn_event_add(&event->devent, &event->call);
726721a51838e3 Tom Zanussi             2020-05-28  1417  	else
726721a51838e3 Tom Zanussi             2020-05-28  1418  		free_synth_event(event);
726721a51838e3 Tom Zanussi             2020-05-28  1419   out:
726721a51838e3 Tom Zanussi             2020-05-28  1420  	mutex_unlock(&event_mutex);
726721a51838e3 Tom Zanussi             2020-05-28  1421  
c9e759b1e8456a Tom Zanussi             2021-02-01  1422  	kfree(saved_fields);
c9e759b1e8456a Tom Zanussi             2021-02-01  1423  
726721a51838e3 Tom Zanussi             2020-05-28  1424  	return ret;
c24be24aed405d Miaoqian Lin            2021-12-09  1425   err_free_arg:
c24be24aed405d Miaoqian Lin            2021-12-09  1426  	argv_free(argv);
726721a51838e3 Tom Zanussi             2020-05-28  1427   err:
726721a51838e3 Tom Zanussi             2020-05-28  1428  	for (i = 0; i < n_fields; i++)
726721a51838e3 Tom Zanussi             2020-05-28  1429  		free_synth_field(fields[i]);
726721a51838e3 Tom Zanussi             2020-05-28  1430  
726721a51838e3 Tom Zanussi             2020-05-28  1431  	goto out;
726721a51838e3 Tom Zanussi             2020-05-28  1432  }
726721a51838e3 Tom Zanussi             2020-05-28  1433  

:::::: The code at line 1295 was first introduced by commit
:::::: c9e759b1e8456a460f258fcfe9682003fcf03938 tracing: Rework synthetic event command parsing

:::::: TO: Tom Zanussi <zanussi@kernel.org>
:::::: CC: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
